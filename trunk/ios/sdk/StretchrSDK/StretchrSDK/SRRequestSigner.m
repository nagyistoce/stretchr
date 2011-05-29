//
//  SRRequestSigner.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>
#import "SRRequestSigner.h"
#import "SRRequest.h"
#import "SRParameterCollection.h"
#import "SRCredentials.h"
#import "NSString+URLEncoding.h"

@implementation SRRequestSigner

- (void)configureSignParameterOnRequest:(SRRequest*)request {
  NSString *signature = [self generatorSignatureFromRequest:request];
  [request.parameters setSingleValue:signature forKey:SIGN_PARAMETER_KEY];
}

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request {
  return [self HMAC_SHA1SignatureForText:[self unencodedSignatureStringForRequest:request]];
}

- (NSString*)unencodedSignatureStringForRequest:(SRRequest*)request {
  return [NSString stringWithFormat:@"%@&%@&%@", [self uppercaseProtocolForRequest:request], [[self stringLowercaseUrl:request.url] urlEncoded], [self orderedParameterStringWithSecretForRequest:request]];
}

- (NSString*)orderedParameterStringWithSecretForRequest:(SRRequest*)request {
  return [[NSString stringWithFormat:@"%@&%@=%@", [request.parameters orderedParameterString], SECRET_PARAMETER_KEY, request.credentials.secret] urlEncoded];
}

- (NSString*)uppercaseProtocolForRequest:(SRRequest*)request {
  
  switch (request.method) {
    case SRRequestMethodGET:
      return GET_HTTP_METHOD;
      break;
    case SRRequestMethodPOST:
      return POST_HTTP_METHOD;
      break;
    case SRRequestMethodPUT:
      return PUT_HTTP_METHOD;
      break;
    case SRRequestMethodDELETE:
      return DELETE_HTTP_METHOD;
      break;
  }
  
  return nil;
  
}

- (NSString*)stringLowercaseUrl:(NSURL*)url {
  return [[url absoluteString] lowercaseString];
}

- (NSString *)HMAC_SHA1SignatureForText:(NSString *)text {
  
  // get the text as data
  NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
  
  // create a memory buffer to hold the digest
  unsigned char digest[CC_SHA1_DIGEST_LENGTH];
  
  // perform the SHA-1 hashing
  CC_SHA1([textData bytes], [textData length], digest);
  
  // convert the digest to NSData
  NSData *digestData = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
  
  // turn it back into a string
  NSString *digestString = [digestData description];
  digestString = [digestString stringByReplacingOccurrencesOfString:@" " withString:@""];
  digestString = [digestString stringByReplacingOccurrencesOfString:@"<" withString:@""];
  digestString = [digestString stringByReplacingOccurrencesOfString:@">" withString:@""];
  
  // TODO: find a more elegant way of doing this bit!
  
  return digestString;
  
}

@end

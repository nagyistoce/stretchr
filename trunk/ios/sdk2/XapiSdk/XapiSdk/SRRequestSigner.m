//
//  SRRequestSigner.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>
#import "SRRequestSigner.h"
#import "SRRequest.h"
#import "SRParameterCollection.h"
#import "SRCredentials.h"
#import "NSString+URLEncoding.h"
#import "Base64Transcoder.h"

@implementation SRRequestSigner

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request {
  return [self HMAC_SHA1SignatureForText:[self unencodedSignatureStringForRequest:request] usingSecret:request.credentials.secret];
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
/*  
  // build the domain
  NSString *domain = [[NSString stringWithFormat:@"%@://%@", [url scheme], [url host]] lowercaseString];
  
  // add the path
  NSString *formattedUrl = [NSString stringWithFormat:@"%@%@", domain, [url path]];
  
  // return the formatted string
  return formattedUrl;
  */
}

- (NSString *)HMAC_SHA1SignatureForText:(NSString *)text usingSecret:(NSString *)secret {
  
	NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
	NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_SHA1_DIGEST_LENGTH];
  
	CCHmacContext hmacContext;
	bzero(&hmacContext, sizeof(CCHmacContext));
  CCHmacInit(&hmacContext, kCCHmacAlgSHA1, secretData.bytes, secretData.length);
  CCHmacUpdate(&hmacContext, textData.bytes, textData.length);
  CCHmacFinal(&hmacContext, result);
  
  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", result[i]];
  
  return output;
  
  /*
  NSLog(@"digest: %@", output);
	
	//Base64 Encoding
	char base64Result[32];
	size_t theResultLength = 32;
	Base64EncodeData(result, 20, base64Result, &theResultLength);
	NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
	NSString *base64EncodedResult = [[[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding] autorelease];
	
	return base64EncodedResult;
  */
  
}

@end

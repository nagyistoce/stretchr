//
//  SRRequestSigner.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRRequestSigner.h"
#import "SRRequest.h"

@implementation SRRequestSigner

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request {

  
  return @"";
  
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

- (NSString*)urlEncodedString:(NSString*)unencodedString {
  
  NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(
                                NULL,
                                (CFStringRef)unencodedString,
                                NULL,
                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                kCFStringEncodingUTF8 );
  
  
  return encodedString;
  
  
}

@end

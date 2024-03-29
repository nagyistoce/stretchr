//
//  NSString+URLEncoding.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "NSString+URLEncoding.h"
#import "Constants.h"

@implementation NSString (URLEncoding)

- (NSString*)urlEncoded {
  
  return (NSString *)CFURLCreateStringByAddingPercentEscapes(
    NULL,
    (CFStringRef)self,
    NULL,
    (CFStringRef)URL_CHARACTERS_TO_ENCODE,
    kCFStringEncodingUTF8 );
  
}

@end

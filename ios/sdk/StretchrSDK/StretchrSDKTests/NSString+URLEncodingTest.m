//
//  NSString+URLEncodingTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "NSString+URLEncodingTest.h"
#import "NSString+URLEncoding.h"

@implementation NSString_URLEncodingTest

- (void)testUrlEncode {
  
  NSString *original = @"Mat&Grant/Ryer&Edd";
  NSString *expected = @"Mat%26Grant%2FRyer%26Edd";
  
  NSString *actual = [original urlEncoded];
  
  STAssertTrue([expected isEqualToString:actual], @"'%@' expected but was '%@'.", expected, actual);
  
}

@end

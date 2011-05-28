//
//  NSString+URLEncodingTest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "NSString+URLEncodingTest.h"
#import "NSString+URLEncoding.h"

@implementation NSString_URLEncodingTest

- (void)testUrlEncode {
  
  NSString *original = @"Mat&Grant/Ryer&Edd";
  NSString *expected = @"Mat%26Grant%2FRyer%26Edd";
  
  NSString *actual = [original urlEncoded];
  
  NSLog(@"%@", actual);
  
  STAssertTrue([expected isEqualToString:actual], @"'%@' expected but was '%@'.", expected, actual);
  
}

@end

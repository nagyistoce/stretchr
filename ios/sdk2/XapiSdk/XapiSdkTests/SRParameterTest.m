//
//  SRParameterTest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRParameterTest.h"
#import "SRParameter.h"
#import "TestValues.h"

@implementation SRParameterTest

- (void)testInitWithKeyAndValue {
  
  SRParameter *param = [[SRParameter alloc] initWithKey:PARAM1_KEY andValue:PARAM1_VALUE];
  
  STAssertEquals(PARAM1_KEY, param.key, @"key should have been set");
  STAssertEquals(PARAM1_VALUE, param.value, @"value should have been set");
  
  [param release];
  
}

- (void)testUrlEncodedParameterString {
  
  SRParameter *param1 = [[SRParameter alloc] initWithKey:@"~z" andValue:@"Mat&Grant/Ryer&Edd"];
  NSString *encodedParamString = [param1 URLEncodedParameterString];
  
  STAssertTrue([encodedParamString isEqualToString:@"~z=Mat%26Grant%2FRyer%26Edd"], @"URLEncodedParameterString incorrect");
  
  [param1 release];
  
}

- (void)testCompareSimple {
  
  SRParameter *param1 = [[SRParameter alloc] initWithKey:@"a" andValue:@"a"];
  SRParameter *param2 = [[SRParameter alloc] initWithKey:@"b" andValue:@"b"];
  
  STAssertEquals(NSOrderedAscending, [param1 compare:param2], @"compare returned incorrect order");
  STAssertEquals(NSOrderedDescending, [param2 compare:param1], @"compare returned incorrect order");
  
  [param1 release];
  [param2 release];
  
}

- (void)testCompareWithCase {
  
  SRParameter *param1 = [[SRParameter alloc] initWithKey:@"a" andValue:@"a"];
  SRParameter *param2 = [[SRParameter alloc] initWithKey:@"B" andValue:@"B"];
  
  STAssertEquals(NSOrderedDescending, [param1 compare:param2], @"compare returned incorrect order");
  STAssertEquals(NSOrderedAscending, [param2 compare:param1], @"compare returned incorrect order");
  
  [param1 release];
  [param2 release];
  
}

- (void)testCompareWithSameKey {
  
  SRParameter *param1 = [[SRParameter alloc] initWithKey:@"A" andValue:@"a"];
  SRParameter *param2 = [[SRParameter alloc] initWithKey:@"A" andValue:@"B"];
  
  STAssertEquals(NSOrderedDescending, [param1 compare:param2], @"compare returned incorrect order");
  STAssertEquals(NSOrderedAscending, [param2 compare:param1], @"compare returned incorrect order");
  
  [param1 release];
  [param2 release];
  
}

- (void)testParameterNames {
  
  STAssertTrue([KEY_PARAMETER_KEY isEqualToString:@"~key"], @"~key incorrect");
  STAssertTrue([SECRET_PARAMETER_KEY isEqualToString:@"~secret"], @"~key incorrect");
  STAssertTrue([SIGN_PARAMETER_KEY isEqualToString:@"~sign"], @"~key incorrect");
  
}

@end

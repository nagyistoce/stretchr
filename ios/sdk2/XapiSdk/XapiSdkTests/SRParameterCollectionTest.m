//
//  SRParameterCollectionTest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRParameterCollectionTest.h"
#import "SRParameterCollection.h"
#import "TestValues.h"

@implementation SRParameterCollectionTest

- (void)testInit {

  SRParameterCollection *params = [[SRParameterCollection alloc] init];
  
  STAssertNotNil(params.parameters, @"parameters should exist");
  
  [params release];
  
}

- (void)testAddValueForKey {
  
  SRParameterCollection *params = [[SRParameterCollection alloc] init];
  
  [params addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  STAssertEquals((NSUInteger)1, [params count], @"count should go up by one");
  STAssertEquals(PARAM1_VALUE, [params objectAtIndex:0].value, @"value should be correct");
  STAssertEquals(PARAM1_KEY, [params objectAtIndex:0].key, @"key should be correct");
  
  // add a different value but the SAME key
  [params addValue:PARAM2_VALUE forKey:PARAM1_KEY];
  STAssertEquals((NSUInteger)2, [params count], @"count should go up by one");
  STAssertEquals(PARAM2_VALUE, [params objectAtIndex:1].value, @"value should be correct");
  STAssertEquals(PARAM1_KEY, [params objectAtIndex:1].key, @"key should be correct");
  
  [params release];
  
}

- (void)testOrderedParameterString {
  
  SRParameterCollection *params = [[SRParameterCollection alloc] init];
  
  // add the parameters (in a strange order)
  [params addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [params addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [params addValue:KEYPARAM_VALUE forKey:KEYPARAM_KEY];
  [params addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  [params addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [params addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  
  // add another one with illegal characters in it
  [params addValue:@"Mat&Grant/Ryer&Edd" forKey:@"~z"];
  
  NSString *paramString = [params orderedParameterString];
  
  /*
  NSLog(@"------------------------------------------------------------");
  NSLog(@"Expected: %@", EXPECTED_PARAMETER_STRING);
  NSLog(@"Actual:   %@", paramString);
  NSLog(@"------------------------------------------------------------");
  */
  
  STAssertTrue([paramString isEqualToString:EXPECTED_PARAMETER_STRING], @"orderedParameterString incorrect.");
  
}

@end

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

- (void)initWithKeyAndValue {
  
  SRParameter *param = [[SRParameter alloc] initWithKey:PARAM1_KEY andValue:PARAM1_VALUE];
  
  STAssertEquals(PARAM1_KEY, param.key, @"key should have been set");
  STAssertEquals(PARAM1_VALUE, param.value, @"value should have been set");
  
  [param release];
  
}

@end

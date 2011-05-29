//
//  SRResourceTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRResourceTest.h"
#import "SRFoundation.h"
#import "SRResource.h"
#import "TestHelper.h"
#import "TestValues.h"

@implementation SRResourceTest

- (void)testInit {
  
  SRResource *resource = [[SRResource alloc] init];
  
  STAssertNotNil(resource.parameters, @"parameters shouldn't be nil");
  
  [resource release];
  
}

- (void)testInitWithPath {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  STAssertEqualStrings([resource path], TEST_PATH, @"initWithPath didn't set the correct path");

  [resource release];
  
}

- (void)testAddParameterValueForKey {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  
  STAssertEquals([[resource parameters] count], (NSUInteger)2, @"Expected to have 2 parameters");
  
  STAssertEqualStrings([resource.parameters objectAtIndex:0].key, PARAM1_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].value, PARAM1_VALUE, @"value incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:1].key, PARAM2_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:1].value, PARAM2_VALUE, @"value incorrect");
  
  [resource release];
  
}

@end

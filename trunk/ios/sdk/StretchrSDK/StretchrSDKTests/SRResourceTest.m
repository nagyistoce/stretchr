//
//  SRResourceTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRResourceTest.h"
#import "SRResource.h"
#import "TestHelper.h"

#define TEST_PATH @"/people"

@implementation SRResourceTest

- (void)testInit {
  
  SRResource *resource = [[SRResource alloc] init];
  
  STAssertNotNil(resource.parameters, @"parameters shouldn't be nil");
  
  [resource release];
  
}

- (void)testInitWithPath {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  STAssertEqualStrings(TEST_PATH, [resource path], @"initWithPath didn't set the correct path");

  [resource release];
  
}

@end

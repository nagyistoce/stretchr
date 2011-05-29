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

@implementation SRResourceTest

- (void)testInitWithPath {
  
  NSString *testPath = @"/people";
  SRResource *resource = [[SRResource alloc] initWithPath:testPath];
  
  STAssertEqualStrings(testPath, [resource path], @"initWithPath didn't set the correct path");
  
  [resource release];
  
}

@end

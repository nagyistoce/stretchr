//
//  StretchrHttpResourceTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrHttpResourceTest.h"
#import "TestHelpers.h"

@implementation StretchrHttpResourceTest

- (void)testInit {
  
  StretchrHttpResource *resource = [[StretchrHttpResource alloc] initWithPath:@"/people/something-else"];
  STAssertStringsEqual(resource.path, @"/people/something-else", @"Resource path incorrect");
  [resource release];
  
}

- (void)testFullRelativeUrls {
  
  StretchrHttpResource *resource = [[StretchrHttpResource alloc] initWithPath:@"/people/something-else"];
  STAssertStringsEqual([resource fullRelativePathUrl], @"/people/something-else", @"Resource path incorrect");
  [resource release];
  
}

@end

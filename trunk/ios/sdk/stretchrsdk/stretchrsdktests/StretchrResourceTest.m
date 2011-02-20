//
//  StretchrResourceTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResourceTest.h"
#import "TestHelpers.h"

@implementation StretchrResourceTest

- (void)testInitWithPath {
  
  NSString *path = @"/people/1";
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:path];
  
  STAssertStringsEqual(resource.path, path, @"resource.path incorrect");
  STAssertNotNil(resource.properties, @"resource.properties shouldn't be nil");
  
  [resource release];
  
}

- (void)testInitWithPathAndProperties {
  
  NSString *path = @"/people/1";
  NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:4];
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:path andProperties:properties];
  
  STAssertStringsEqual(resource.path, path, @"resource.path incorrect");
  STAssertEquals(resource.properties, properties, @"resource.properties incorrect");
  
  [properties release];
  [resource release];
  
}

@end

//
//  StretchrResourceTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
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

- (void)testDescribingANewResource {
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people"];
  
  [resource.properties setValue:@"Edd" forKey:@"name"];
  [resource.properties setValue:@"Grant" forKey:@"surname"];
  
  STAssertStringsEqual([resource.properties objectForKey:@"name"], @"Edd", @"resource.properties.name incorrect");
  STAssertStringsEqual([resource.properties objectForKey:@"surname"], @"Grant", @"resource.properties.surname incorrect");
  
  [resource release];
  
}

- (void)testDescribingAnExistingResource {
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people" andId:@"1"];
  
  STAssertStringsEqual(resource.resourceId, @"1", @"resource.resourceId incorrect");
  
  [resource release];
  
}

- (void)testExists {
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people" andId:@"1"];
  STAssertTrue([resource exists], @"exists should be YES");
  [resource release];
  
  StretchrResource *resource2 = [[StretchrResource alloc] initWithPath:@"/people" andId:nil];
  STAssertFalse([resource2 exists], @"exists should be NO");
  [resource2 release];
  
}


- (void)testFullRelativePath {
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/1/groups" andId:@"123"];
  STAssertStringsEqual([resource fullRelativePath], @"/people/1/groups/123", @"resource fullRelativePath incorrect");
  
  StretchrResource *resource2 = [[StretchrResource alloc] initWithPath:@"/people/1/groups"];
  STAssertStringsEqual([resource2 fullRelativePath], @"/people/1/groups", @"resource fullRelativePath incorrect");
  
}

@end

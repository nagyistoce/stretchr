//
//  StretchrResourceTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrResourceTest.h"
#import "TestHelpers.h"
#import "StretchrConstants.h"

@implementation StretchrResourceTest

- (void)setUp {
  
  testResource = [[StretchrResource alloc] init];
  
}
- (void)tearDown {
  [testResource release];
}

- (void)testInit {
  
  STAssertNotNil(testResource.properties, @".properties should be set by init");
  
}

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

- (void)testResourceId {
  
  STAssertNil([testResource resourceId], @"resourceId should start nil");
  
  [testResource setResourceId:@"123"];
  
  STAssertNotNil([testResource resourceId], @"resourceId should not be nil");
  
  STAssertStringsEqual([testResource.properties valueForKey:@"id"], @"123", @"resourceId should be set");
  STAssertStringsEqual([testResource resourceId], @"123", @"resourceId should be set");
  
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
  STAssertStringsEqual([resource fullRelativePathUrl], @"/people/1/groups", @"resource fullRelativePath incorrect");
  
  StretchrResource *resource2 = [[StretchrResource alloc] initWithPath:@"/people/1/groups"];
  STAssertStringsEqual([resource2 fullRelativePathUrl], @"/people/1/groups", @"resource fullRelativePath incorrect");
  
}

#pragma mark - Data

- (void)testPostBodyStringIncludingId {
  
  [testResource.properties setValue:@"Mat" forKey:@"name"];
  [testResource.properties setValue:@"Ryer" forKey:@"surname"];
  [testResource.properties setValue:@"28" forKey:@"age"];
  [testResource.properties setValue:@"123" forKey:StretchrResourceIdPropertyKey];
  
  MRLog([testResource postBodyStringIncludingId:YES]);
  
  STAssertStringsEqual([testResource postBodyStringIncludingId:YES], @"age=28&name=Mat&id=123&surname=Ryer", @"postBodyString incorrect.");
  
  STAssertStringsEqual([testResource postBodyStringIncludingId:NO], @"age=28&name=Mat&surname=Ryer", @"postBodyString incorrect.");
  
}

@end

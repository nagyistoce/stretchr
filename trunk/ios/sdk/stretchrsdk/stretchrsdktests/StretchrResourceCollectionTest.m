//
//  StretchrResourceCollectionTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResourceCollectionTest.h"
#import "TestHelpers.h"

@implementation StretchrResourceCollectionTest

- (void)setUp {
  
  NSString *path = @"/people";
  
  resources = [[StretchrResourceCollection alloc] initWithPath:path];
  
}

- (void)tearDown {
  
  [resources release];
  resources = nil;
  
}

- (void)testInit {
  
  StretchrResourceCollection *rs = [[StretchrResourceCollection alloc] initWithPath:@"/people"];
  
  STAssertEquals(rs.path, @"/people", @"resources.path incorrect");
  
  [rs release];
  
}

- (void)testProperties {
  
  resources.totalLength = 100;
  STAssertEquals(resources.totalLength, (NSUInteger)100, @"resources.totalLength incorrect");
  
  resources.startIndex = 0;
  STAssertEquals(resources.startIndex, (NSUInteger)0, @"resources.totalLength incorrect");
  
  resources.endIndex = 9;
  STAssertEquals(resources.endIndex, (NSUInteger)9, @"resources.totalLength incorrect");
  
  NSArray *testResources = [[NSArray alloc] initWithObjects:@"", nil];
  resources.resources = testResources;
  STAssertEquals(resources.resources, testResources, @"resources.resources incorrect");
  [testResources release];
  
}

@end

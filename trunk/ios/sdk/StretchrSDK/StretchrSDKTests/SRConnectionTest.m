//
//  SRConnectionTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "TestHelper.h"
#import "SRConnectionTest.h"
#import "SRConnection.h"

@implementation SRConnectionTest

- (void)testInitWithRequest {
  
  NSURLRequest *request = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:request];
  
  STAssertEqualObjects([conn request], request, @"initWithRequest didn't set request");
  STAssertNotNil([conn underlyingConnection], @"initWithRequest didn't create underlyingConnection");
  
  [request release];
  [conn release];
  
}

- (void)testInitWithRequestTargetSelector {
  
  NSObject *targetObject = [[NSObject alloc] init];
  
  NSURLRequest *request = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:request target:targetObject selector:@selector(description)];
  
  STAssertEqualObjects([conn request], request, @"initWithRequest didn't set request");
  STAssertNotNil([conn underlyingConnection], @"initWithRequest didn't create underlyingConnection");
  
  STAssertEqualObjects(targetObject, conn.target, @"target not set");
  STAssertEqualStrings(NSStringFromSelector(conn.selector), @"description", @"selector incorrect.");

  [request release];
  [conn release];
  [targetObject release];
  
}

@end

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
#import "TestTargetObject.h"
#import "SRResponse.h"

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

- (void)testDidReceiveResponse {
  
  // create a test target object
  TestTargetObject *target = [[TestTargetObject alloc] init];
  
  // create the request and connection
  NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:urlRequest target:target selector:@selector(processResponse:)];
  
  // create test connection and response objects
  NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:nil];
  NSURLResponse *urlResponse = [[NSURLResponse alloc] init];
  
  // call didReceiveResponse
  [conn connection:urlConnection didReceiveResponse:urlResponse];
  
  // ensure the target method received the response
  STAssertNotNil(target.lastResponse, @"processResponse: should have been called on the target");
  
  // make sure the response object has the right properties
  STAssertEqualObjects(target.lastResponse.connection, conn, @"response.connection incorrect");
  STAssertEqualObjects(target.lastResponse.urlResponse, urlResponse, @"response.urlResponse incorrect");
  STAssertNil(target.lastResponse.error, @"Should be no error object");
  
  // tidy up
  [urlRequest release];
  [conn release];
  [urlConnection release];
  [urlResponse release];
  [target release];
  
}

- (void)testDidReceiveError {
  
  // create a test target object
  TestTargetObject *target = [[TestTargetObject alloc] init];
  
  // create the request and connection
  NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:urlRequest target:target selector:@selector(processResponse:)];
  
  // create test connection and response objects
  NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:nil];
  NSError *theError = [[NSError alloc] init];
  
  // call didReceiveResponse
  [conn connection:urlConnection didFailWithError:theError];
  
  // ensure the target method received the response
  STAssertNotNil(target.lastResponse, @"processResponse: should have been called on the target");
  
  // make sure the response object has the right properties
  STAssertEqualObjects(target.lastResponse.connection, conn, @"response.connection incorrect");
  STAssertEqualObjects(target.lastResponse.error, theError, @"response.error incorrect");
  STAssertNil(target.lastResponse.urlResponse, @"Should be no urlResponse object");
  
  // tidy up
  [urlRequest release];
  [conn release];
  [urlConnection release];
  [theError release];
  [target release];
  
}

@end

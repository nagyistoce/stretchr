//
//  SRConnectionTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "TestHelper.h"
#import "SRConnectionTest.h"
#import "SRConnection.h"
#import "TestTargetObject.h"
#import "SRResponse.h"
#import "SRRequest.h"

@implementation SRConnectionTest

- (void)testInitWithRequestOriginalRequest {
  
  NSURLRequest *request = [[NSURLRequest alloc] init];
  SRRequest *originalRequest = [[SRRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:request originalRequest:originalRequest];
  
  STAssertEqualObjects([conn request], request, @"initWithRequest didn't set request");
  STAssertNotNil([conn underlyingConnection], @"initWithRequest didn't create underlyingConnection");
  
  STAssertEqualObjects(originalRequest, [conn originalRequest], @"Original request not set");
  
  [request release];
  [conn release];
  [originalRequest release];
  
}

- (void)testInitWithRequestTargetSelector {
  
  NSObject *targetObject = [[NSObject alloc] init];
  SRRequest *originalRequest = [[SRRequest alloc] init];
  NSURLRequest *request = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:request originalRequest:originalRequest target:targetObject selector:@selector(description)];
  
  STAssertEqualObjects([conn request], request, @"initWithRequest didn't set request");
  STAssertNotNil([conn underlyingConnection], @"initWithRequest didn't create underlyingConnection");
  
  STAssertEqualObjects(originalRequest, [conn originalRequest], @"Original request not set");
  
  STAssertEqualObjects(targetObject, conn.target, @"target not set");
  STAssertEqualStrings(NSStringFromSelector(conn.selector), @"description", @"selector incorrect.");

  [request release];
  [conn release];
  [targetObject release];
  [originalRequest release];
  
}

- (void)testConnectionDidReceiveResponse {
  
  // create a test target object
  TestTargetObject *target = [[TestTargetObject alloc] init];
  
  // create the request and connection
  SRRequest *originalRequest = [[SRRequest alloc] init];
  NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:urlRequest originalRequest:originalRequest target:target selector:@selector(processResponse:)];
  
  // create test connection and response objects
  NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:nil];
  NSURLResponse *urlResponse = [[NSURLResponse alloc] init];
  
  NSData *testData = [@"data-stream-one" dataUsingEncoding:NSUTF8StringEncoding];
  
  // send some data
  [conn connection:urlConnection didReceiveData:testData];
  
  // call didReceiveResponse
  [conn connection:urlConnection didReceiveResponse:urlResponse];
  
  // ensure the target method received the response
  STAssertNotNil(target.lastResponse, @"processResponse: should have been called on the target");
  
  // make sure the response object has the right properties
  STAssertTrue([target.lastResponse.data isEqualToData:testData], @"The data in the response should be the data passed in through connection:didReceiveData:");
  STAssertEqualObjects(target.lastResponse.connection, conn, @"response.connection incorrect");
  STAssertEqualObjects(target.lastResponse.urlResponse, urlResponse, @"response.urlResponse incorrect");
  STAssertNil(target.lastResponse.error, @"Should be no error object");
  
  // tidy up
  [urlRequest release];
  [conn release];
  [urlConnection release];
  [urlResponse release];
  [target release];
  [originalRequest release];
  
}

- (void)testConnectionDidReceiveError {
  
  // create a test target object
  TestTargetObject *target = [[TestTargetObject alloc] init];
  
  // create the request and connection
  SRRequest *originalRequest = [[SRRequest alloc] init];
  NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:urlRequest originalRequest:originalRequest target:target selector:@selector(processResponse:)];
  
  // create test connection and response objects
  NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:nil];
  NSError *theError = [[NSError alloc] init];
  
  // send some test data
  NSData *testData = [@"data-stream-one" dataUsingEncoding:NSUTF8StringEncoding];
  [conn connection:urlConnection didReceiveData:testData];
  
  // call didReceiveResponse
  [conn connection:urlConnection didFailWithError:theError];
  
  // ensure the target method received the response
  STAssertNotNil(target.lastResponse, @"processResponse: should have been called on the target");
  
  // make sure the response object has the right properties
  STAssertEqualObjects(target.lastResponse.connection, conn, @"response.connection incorrect");
  STAssertEqualObjects(target.lastResponse.error, theError, @"response.error incorrect");
  STAssertTrue([target.lastResponse.data isEqualToData:testData], @"The data in the response should be the data passed in through connection:didReceiveData:");
  
  STAssertNil(target.lastResponse.urlResponse, @"Should be no urlResponse object");
  
  // tidy up
  [urlRequest release];
  [conn release];
  [urlConnection release];
  [theError release];
  [target release];
  [originalRequest release];
  
}

- (void)testConnectionDidReceiveData {
  
  SRRequest *originalRequest = [[SRRequest alloc] init];
  NSURLRequest *urlRequest = [[NSURLRequest alloc] init];
  NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:nil];
  SRConnection *conn = [[SRConnection alloc] initWithRequest:urlRequest originalRequest:originalRequest target:nil selector:nil];
  
  STAssertNil(conn.receivedData, @"receivedData should start off nil");
  
  // send in some data
  NSData *dataLoadOne = [@"data-stream-one" dataUsingEncoding:NSUTF8StringEncoding];
  
  [conn connection:urlConnection didReceiveData:dataLoadOne];
  
  STAssertNotNil(conn.receivedData, @"Some data should exist");
  STAssertTrue([conn.receivedData isEqualToData:dataLoadOne], @"So far, the data should equal our first set");
  
  // send in some more data
  NSData *dataLoadTwo = [@"data-stream-two" dataUsingEncoding:NSUTF8StringEncoding];
  
  [conn connection:urlConnection didReceiveData:dataLoadTwo];
  
  // build up the test data
  NSMutableData *testData = [[NSMutableData alloc] init];
  [testData appendData:dataLoadOne];
  [testData appendData:dataLoadTwo];
  
  STAssertTrue([conn.receivedData isEqualToData:testData], @"Data should be equal to test data");
  
  [testData release];
  [urlConnection release];
  [originalRequest release];
  [urlRequest release];
  [conn release];
  
}

@end

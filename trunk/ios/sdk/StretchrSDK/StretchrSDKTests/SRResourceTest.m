//
//  SRResourceTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRResourceTest.h"
#import "SRFoundation.h"
#import "SRResource.h"
#import "TestHelper.h"
#import "TestValues.h"
#import "TestTargetObject.h"
#import "SRConnection.h"
#import "Constants.h"

@implementation SRResourceTest

- (void)testInit {
  
  SRResource *resource = [[SRResource alloc] init];
  
  STAssertNotNil(resource.parameters, @"parameters shouldn't be nil");
  
  [resource release];
  
}

- (void)testInitWithPath {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  STAssertEqualStrings([resource path], TEST_PATH, @"initWithPath didn't set the correct path");
  
  [resource release];
  
}

- (void)testInitWithPathResourceId {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH resourceId:TEST_RESOURCE_ID];
  
  STAssertEqualStrings([resource path], TEST_PATH, @"testInitWithPathResourceId didn't set the correct path");
  STAssertEqualStrings([resource resourceId], TEST_RESOURCE_ID, @"testInitWithPathResourceId didn't set the correct resourceId");
  
  [resource release];
  
}

- (void)testAddParameterValueForKey {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  
  STAssertEquals([[resource parameters] count], (NSUInteger)2, @"Expected to have 2 parameters");
  
  STAssertEqualStrings([resource.parameters objectAtIndex:0].key, PARAM1_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].value, PARAM1_VALUE, @"value incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:1].key, PARAM2_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:1].value, PARAM2_VALUE, @"value incorrect");
  
  [resource release];
  
}

- (void)testAddParameterValueForKeyWithMultipleItems {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  
  STAssertEquals([[resource parameters] count], (NSUInteger)6, @"Expected to have 6 parameters");
  
  [resource release];
  
}

- (void)testSetParameterValueForKey {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource setParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];

  STAssertEquals([[resource parameters] count], (NSUInteger)1, @"Expected to have 1 parameter");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].key, PARAM1_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].value, PARAM1_VALUE, @"value incorrect");
  
  [resource setParameterValue:PARAM2_VALUE forKey:PARAM1_KEY];
  
  STAssertEquals([[resource parameters] count], (NSUInteger)1, @"Expected to have 1 parameter");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].key, PARAM1_KEY, @"key incorrect");
  STAssertEqualStrings([resource.parameters objectAtIndex:0].value, PARAM2_VALUE, @"value incorrect");
  
  [resource release];
  
}

- (void)testFirstValueForKey {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource addParameterValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [resource addParameterValue:PARAM3_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM3_VALUE forKey:PARAM2_KEY];
  [resource addParameterValue:PARAM4_VALUE forKey:PARAM1_KEY];
  [resource addParameterValue:PARAM4_VALUE forKey:PARAM2_KEY];
  
  NSString *value = [resource firstValueForKey:PARAM1_KEY];
  STAssertEqualStrings(value, PARAM1_VALUE, @"firstValueForKey returned the wrong thing.");
  
  // if no param, expect nil response
  value = [resource firstValueForKey:@"no-such-key"];
  STAssertNil(value, @"response of firstValueForKey with non-existing key should be nil");
  
  [resource release];
  
}

- (void)testResourceId {
  
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  [resource setResourceId:TEST_RESOURCE_ID];
  
  NSString *value = [resource firstValueForKey:ID_PARAMETER_KEY];
  STAssertNil(value, @"Resource shouldn't set ID as parameter");
  STAssertEqualStrings([resource resourceId], TEST_RESOURCE_ID, @"~id was not correct.");
 
  [resource release];
  
}

- (void)testHasResourceId {
  
  NSString *testId = @"testId";
  SRResource *resource = [[SRResource alloc] initWithPath:TEST_PATH];
  
  STAssertFalse([resource hasResourceId], @"hasResourceId should be false when no ID");
  
  [resource setResourceId:testId];
  
  STAssertTrue([resource hasResourceId], @"hasResourceId should be true when ID present");
  
  [resource release];
  
}


- (SRResource*)testResource {
  
  SRResource *resource = [[[SRResource alloc] initWithPath:@"/people"] autorelease];
  
  [resource addParameterValue:@"Mat" forKey:@"name"];
  [resource addParameterValue:@"28" forKey:@"age"];
  [resource addParameterValue:@"London" forKey:@"location"];
  
  return resource;
  
}

- (void)testCreateConnectionForRequestTargetSelectorStartImmediately {
 
  SRRequest *originalRequest = [[SRRequest alloc] init];
  TestTargetObject *target = [[TestTargetObject alloc] init];
  SRResource *resource = [self testResource];
  NSURLRequest *underlyingRequest = [[NSURLRequest alloc] init];
  
  SRConnection *connection = [resource createConnectionForRequest:underlyingRequest 
                                              withOriginalRequest:originalRequest
                                                           target:target 
                                                         selector:@selector(processResponse:) 
                                                 startImmediately:NO];
  
  STAssertNotNil(connection, @"createConnectionForRequest:Target:Selector:StartImmediately: should return connection object");
  STAssertEqualObjects(connection.request, underlyingRequest, @"Connection should have correct request");
  STAssertNotNil(connection.underlyingConnection, @"The underlying connection should have been created");
  STAssertEqualObjects(connection.target, target, @"target should be set");
  STAssertEqualStrings(NSStringFromSelector(connection.selector), @"processResponse:", @"Correct selector should have been specified");
  STAssertEqualObjects(connection.originalRequest, originalRequest, @"originalRequest should be set");
  
  [originalRequest release];
  [target release];
  [underlyingRequest release];
  
}

- (void)testCreate {
  
  TestTargetObject *target = [[TestTargetObject alloc] init];
  SRResource *resource = [self testResource];
  
  // create
  SRConnection *connection = [resource createThenCallTarget:target selector:@selector(processResponse:) startImmediately:NO];
  
  STAssertNotNil(connection, @"*thenCallTarget:selector: should return SRConnection object");
  
  // just check the HTTP method to ensure it's correct
  STAssertEqualStrings(connection.request.HTTPMethod, POST_HTTP_METHOD, @"HTTP Method incorrect");
  
  [target release];
  
}
- (void)testRead {
  
  TestTargetObject *target = [[TestTargetObject alloc] init];
  SRResource *resource = [self testResource];
  
  // create
  SRConnection *connection = [resource readThenCallTarget:target selector:@selector(processResponse:) startImmediately:NO];
  
  STAssertNotNil(connection, @"*thenCallTarget:selector: should return SRConnection object");
  
  // just check the HTTP method to ensure it's correct
  STAssertEqualStrings(connection.request.HTTPMethod, GET_HTTP_METHOD, @"HTTP Method incorrect");
  
  [target release];
  
}
- (void)testUpdate {
  
  TestTargetObject *target = [[TestTargetObject alloc] init];
  SRResource *resource = [self testResource];
  
  // create
  SRConnection *connection = [resource updateThenCallTarget:target selector:@selector(processResponse:) startImmediately:NO];
  
  STAssertNotNil(connection, @"*thenCallTarget:selector: should return SRConnection object");
  
  // just check the HTTP method to ensure it's correct
  STAssertEqualStrings(connection.request.HTTPMethod, PUT_HTTP_METHOD, @"HTTP Method incorrect");
  
  [target release];
  
}
- (void)testDelete {
  
  TestTargetObject *target = [[TestTargetObject alloc] init];
  SRResource *resource = [self testResource];
  
  // create
  SRConnection *connection = [resource deleteThenCallTarget:target selector:@selector(processResponse:) startImmediately:NO];
  
  STAssertNotNil(connection, @"*thenCallTarget:selector: should return SRConnection object");
  
  // just check the HTTP method to ensure it's correct
  STAssertEqualStrings(connection.request.HTTPMethod, DELETE_HTTP_METHOD, @"HTTP Method incorrect");
  
  [target release];
  
}
  
@end

//
//  SRRequestFactoryTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "TestHelper.h"
#import "TestValues.h"
#import "SRContext.h"
#import "SRRequestFactoryTest.h"
#import "SRResource.h"
#import "SRRequestFactory.h"
#import "SRRequest.h"
#import "SRParameter.h"
#import "SRParameterCollection.h"

@implementation SRRequestFactoryTest

- (void)setUp {
  [super setUp];
  
  [[SRContext sharedInstance] setAccountName:TEST_ACCOUNT key:TEST_KEY secret:TEST_SECRET];
  
}

- (void)tearDown {
  [super tearDown];
}

- (SRResource*)testResourceWithPostData {
  
  SRResource *resource = [[[SRResource alloc] initWithPath:@"/people"] autorelease];
  
  [resource addParameterValue:@"Mat" forKey:@"name"];
  [resource addParameterValue:@"28" forKey:@"age"];
  [resource addParameterValue:@"London" forKey:@"location"];
  
  return resource;
  
}
- (SRResource*)testResourceWithoutPostData {
  
  SRResource *resource = [[[SRResource alloc] initWithPath:@"/people"] autorelease];
  
  return resource;
  
}

- (void)testRequestToCreateResource {
  
  SRResource *resource = [self testResourceWithPostData];
  SRRequest *request = [SRRequestFactory requestToCreateResource:resource];
  
  NSString *expectedUrl = @"http://EDD-test-domain.xapi.co/people";
  
  STAssertNotNil(request, @"Shouldn't be nil");
  
  // check the URL
  STAssertEqualStrings([request.url absoluteString], expectedUrl, @"URL incorrect.");
  
  // check the parameters
  STAssertEquals([request.parameters count], (NSUInteger)4, @"Wrong number of parameters");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"name"].value, @"Mat", @"name wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"age"].value, @"28", @"age wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"location"].value, @"London", @"location wrong");
  
  // check the credentials
  STAssertEqualObjects(request.credentials, [[SRContext sharedInstance] credentials], @"Creds incorrect");
  
  // check the method
  STAssertEquals(SRRequestMethodPOST, request.method, @"Method incorrect");
  
}

- (void)testRequestToUpdateResource {
  
  SRResource *resource = [self testResourceWithPostData];
  
  NSString *expectedUrl = @"http://EDD-test-domain.xapi.co/people/1";
  
  // give the resource an ID
  [resource setResourceId:TEST_RESOURCE_ID];
  
  SRRequest *request = [SRRequestFactory requestToUpdateResource:resource];
  
  // check the URL
  STAssertEqualStrings([request.url absoluteString], expectedUrl, @"URL incorrect.");
  
  // check the parameters
  STAssertEquals([request.parameters count], (NSUInteger)4, @"Wrong number of parameters");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"name"].value, @"Mat", @"name wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"age"].value, @"28", @"age wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"location"].value, @"London", @"location wrong");
  
  // check the credentials
  STAssertEqualObjects(request.credentials, [[SRContext sharedInstance] credentials], @"Creds incorrect");
  
  // check the method
  STAssertEquals(SRRequestMethodPUT, request.method, @"Method incorrect");
  
}

- (void)testRequestToReadResource {
  
  SRResource *resource = [self testResourceWithoutPostData];
  
  NSString *expectedUrl = [NSString stringWithFormat:@"http://EDD-test-domain.xapi.co/people/1", TEST_KEY];
  
  // give the resource an ID
  [resource setResourceId:TEST_RESOURCE_ID];
  
  SRRequest *request = [SRRequestFactory requestToReadResource:resource];
  
  // check the URL
  STAssertEqualStrings([request.url absoluteString], expectedUrl, @"URL incorrect.");
  
  // check the parameters
  STAssertEquals([request.parameters count], (NSUInteger)1, @"Wrong number of parameters");
  
  // check the credentials
  STAssertEqualObjects(request.credentials, [[SRContext sharedInstance] credentials], @"Creds incorrect");
  
  // check the method
  STAssertEquals(SRRequestMethodGET, request.method, @"Method incorrect");
  
}

- (void)testRequestToDeleteResource {
  
  SRResource *resource = [self testResourceWithoutPostData];
  
  NSString *expectedUrl = @"http://EDD-test-domain.xapi.co/people/1";
  
  // give the resource an ID
  [resource setResourceId:TEST_RESOURCE_ID];
  
  SRRequest *request = [SRRequestFactory requestToDeleteResource:resource];
  
  // check the URL
  STAssertEqualStrings([request.url absoluteString], expectedUrl, @"URL incorrect.");
  
  // check the parameters
  STAssertEquals([request.parameters count], (NSUInteger)1, @"Wrong number of parameters");
  
  // check the credentials
  STAssertEqualObjects(request.credentials, [[SRContext sharedInstance] credentials], @"Creds incorrect");
  
  // check the method
  STAssertEquals(SRRequestMethodDELETE, request.method, @"Method incorrect");
  
}


@end

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

- (SRResource*)testResource {
  
  SRResource *resource = [[[SRResource alloc] initWithPath:@"/people"] autorelease];
  
  [resource addParameterValue:@"Mat" forKey:@"name"];
  [resource addParameterValue:@"28" forKey:@"age"];
  [resource addParameterValue:@"London" forKey:@"location"];
  
  return resource;
  
}

- (void)testRequestToCreateResource {
  
  SRResource *resource = [self testResource];
  SRRequest *request = [SRRequestFactory requestToCreateResource:resource];
  
  STAssertNotNil(request, @"Shouldn't be nil");
  
  // check the URL
  STAssertEqualStrings([request.url absoluteString], @"http://EDD-test-domain.xapi.co/people", @"URL incorrect.");
  
  // check the parameters
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"name"].value, @"Mat", @"name wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"age"].value, @"28", @"age wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"location"].value, @"London", @"location wrong");
  
  // check the method
  STAssertEquals(SRRequestMethodGET, request.method, @"Method incorrect");
  
}

- (void)testRequestToUpdateResource {
  
  
  
}


@end

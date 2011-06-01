//
//  SRRequestFactoryTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "TestHelper.h"
#import "SRRequestFactoryTest.h"
#import "SRResource.h"
#import "SRRequestFactory.h"
#import "SRRequest.h"
#import "SRParameter.h"
#import "SRParameterCollection.h"

@implementation SRRequestFactoryTest

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
  
  // check the parameters
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"name"].value, @"Mat", @"name wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"age"].value, @"28", @"age wrong");
  STAssertEqualStrings([request.parameters firstParameterWithKey:@"location"].value, @"London", @"location wrong");
  
  // check the method
  STAssertEquals(SRRequestMethodGET, request.method, @"Method incorrect");
  
}


@end

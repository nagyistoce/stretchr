//
//  SRRequestTest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRRequestTest.h"
#import "SRRequest.h"
#import "SRCredentials.h"
#import "SRParameterCollection.h"
#import "TestValues.h"

@implementation SRRequestTest




- (void)testInit {
  
  SRRequest *request = [[SRRequest alloc] init];
  STAssertNotNil(request, @"Request shouldn't be nil");
  [request release];
  
}

- (void)testInitWithUrlMethod {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPUT credentials:creds];
  
  STAssertEqualObjects(url, request.url, @"url should have been set");
  STAssertEquals(SRRequestMethodPUT, request.method, @"method should have been set");
  STAssertEqualObjects(creds, request.credentials, @"credentials should have been set");
  
  [creds release];
  [request release];
  
}

- (void)testRequestAutomaticallyAddsKeyParameter {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPUT credentials:creds];
  
  STAssertEquals((NSUInteger)1, [request.parameters count], @"Request should automatically add the key parameter");
  
  /*
  NSLog(@"--------------------------------------------------------");
  NSLog(@"key: %@", [request.parameters objectAtIndex:0].key);
  NSLog(@"value: %@", [request.parameters objectAtIndex:0].value);
  NSLog(@"--------------------------------------------------------");
  */
  
  STAssertTrue([[request.parameters objectAtIndex:0].key isEqualToString:KEY_PARAMETER_KEY], @"key wasn't correctly set");
  STAssertTrue([[request.parameters objectAtIndex:0].value isEqualToString:TEST_KEY], @"key value wasn't correctly set");
  
  [creds release];
  [request release];
  
}

- (void)testParameters {
  
  SRRequest *request = [[SRRequest alloc] init];
  
  STAssertFalse([request hasParameters], @"hasParameters should be false to start with");
  
  // an empty NSMutableDictionay should be returned
  STAssertNotNil([request parameters], @"[request parameters] shouldn't be nil");
  
  STAssertTrue([request hasParameters], @"hasParameters should be true after calling it.");
  
  [request release];
  
}


@end

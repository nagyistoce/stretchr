//
//  SRRequestSignerTest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRRequestSignerTest.h"
#import "SRRequestSigner.h"
#import "SRRequest.h"
#import "SRCredentials.h"
#import "TestValues.h"

@implementation SRRequestSignerTest
@synthesize request;
@synthesize signer;

- (void)setUp {
 
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *aRequest = [[SRRequest alloc] initWithUrl:url method:TEST_METHOD credentials:creds];
  
  // add the parameters
  [aRequest.parameters addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [aRequest.parameters addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [aRequest.parameters addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [aRequest.parameters addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [aRequest.parameters addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  
  self.request = aRequest;
  
  [aRequest release];
  [creds release];
  
  
  SRRequestSigner *aSigner = [[SRRequestSigner alloc] init];
  self.signer = aSigner;
  [aSigner release];
  
  
}

- (void)tearDown {
  
  self.request = nil;
  self.signer = nil;
  
}

- (void)testInit {

  STAssertNotNil(signer, @"Signer shouldn't be nil");
  
}

- (void)testGenerateSignatureForRequest {
  
  NSString *signature = [self.signer generatorSignatureFromRequest:request];
  
  STAssertNotNil(signature, @"Signature should not be nil");
  STAssertFalse([signature isEqualToString:@""], @"signature should not be empty");
  
  STAssertTrue([signature isEqualToString:EXPECTED_SIGNATURE], @"Signature incorrect :-(");
  
}

- (void)testUrlWithLowercaseDomain {
  
  STAssertTrue([[self.signer stringLowercaseUrl:self.request.url] isEqualToString:TEST_LOWERCASE_URL], @"urlWithLowercaseDomain didn't return correct string");
  
}

- (void)testUrlEncodedString {
  
  NSString *unencoded = @"http://edd-test-domain.xapi.co/groups/1/people";
  NSString *expected = @"http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople";
  
  STAssertTrue([expected isEqualToString:[self.signer urlEncodedString:unencoded]], @"urlEncodedString incorrect");
  
}

@end

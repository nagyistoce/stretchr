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

- (void)testOrderedParameterStringWithSecretForRequest {
  
  NSString *orderedParameterString = [self.signer orderedParameterStringWithSecretForRequest:self.request];
  
  /*
  NSLog(@"---------------------------------");
  NSLog(@"orderedParameterString: %@", orderedParameterString);
  NSLog(@"---------------------------------");
  */
  
  STAssertTrue([orderedParameterString isEqualToString:EXPECTED_PARAMETER_STRING_WITH_SECRET], @"orderedParameterStringWithSecret incorrect");
  
}

- (void)testGenerateSignatureForRequest {
  
  NSString *signature = [self.signer generatorSignatureFromRequest:self.request];
  
  STAssertNotNil(signature, @"Signature should not be nil");
  STAssertFalse([signature isEqualToString:@""], @"signature should not be empty");
  
  STAssertTrue([signature isEqualToString:EXPECTED_SIGNATURE], @"Signature incorrect :-(");
  
}

- (void)testUrlWithLowercaseDomain {
  
  STAssertTrue([[self.signer stringLowercaseUrl:self.request.url] isEqualToString:TEST_LOWERCASE_URL], @"urlWithLowercaseDomain didn't return correct string");
  
}

- (void)testUnencodedSignatureStringForRequest {
  
  NSString *signatureString = [self.signer unencodedSignatureStringForRequest:self.request];
  
  NSLog(@"---------------------------------");
  NSLog(@"signatureString: %@", signatureString);
  NSLog(@"---------------------------------");
  
  STAssertTrue([signatureString isEqualToString:EXPECTED_UNENCODED_SIGNATURE_STRING], @"unencodedSignatureString incorrect.");
  
}

- (void)testUppercaseProtocolForRequest {
  
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  
  SRRequest *aRequest = [[SRRequest alloc] initWithUrl:[NSURL URLWithString:@"http://www.stretchr.com/"] method:SRRequestMethodGET credentials:creds];
  STAssertTrue([[self.signer uppercaseProtocolForRequest:aRequest] isEqualToString:@"GET"], @"GET expected");
  [aRequest release];
  
  aRequest = [[SRRequest alloc] initWithUrl:[NSURL URLWithString:@"http://www.stretchr.com/"] method:SRRequestMethodPUT credentials:creds];
  STAssertTrue([[self.signer uppercaseProtocolForRequest:aRequest] isEqualToString:@"PUT"], @"PUT expected");
  [aRequest release];
  
  aRequest = [[SRRequest alloc] initWithUrl:[NSURL URLWithString:@"http://www.stretchr.com/"] method:SRRequestMethodDELETE credentials:creds];
  STAssertTrue([[self.signer uppercaseProtocolForRequest:aRequest] isEqualToString:@"DELETE"], @"DELETE expected");
  [aRequest release];
  
  aRequest = [[SRRequest alloc] initWithUrl:[NSURL URLWithString:@"http://www.stretchr.com/"] method:SRRequestMethodPOST credentials:creds];
  STAssertTrue([[self.signer uppercaseProtocolForRequest:aRequest] isEqualToString:@"POST"], @"POST expected");
  [aRequest release];
  
  [creds release];
  
}

- (void)testHMAC_SHA1SignatureForText {
  
  NSString *plain = @"POST&http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople&FName%3DEdd%26email%3Dedd%40eddgrant.com%26email%3Dedd%40stretchr.com%26%7Ec%3Dthis-is-my-context-value%26%7Ekey%3Dabdh239d78c30f93jf88r0%26%7Esecret%3DthisIsMySecretValue";
  NSString *secret = @"thisIsMySecretValue";
  NSString *expectedSignature = @"bc32e193e0fbe8f7dc81b11fdc5a90d2b52a3b7c";
  
  NSString *actualSignature = [self.signer HMAC_SHA1SignatureForText:plain usingSecret:secret];
  
  STAssertTrue([actualSignature isEqualToString:expectedSignature], @"Signature incorrect.  Expected: '%@' but was '%@'.", expectedSignature, actualSignature);
  
}

@end

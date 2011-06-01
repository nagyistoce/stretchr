//
//  SRRequestSignerTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
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

- (void)testConfigureSignParameterOnRequest {
  
  [self.signer configureSignParameterOnRequest:self.request];
  
  // check the sign parameter
  BOOL found = NO;
  for (SRParameter *param in self.request.parameters.parameters) {
    if ([param.key isEqualToString:SIGN_PARAMETER_KEY]) {
      
      // found it
      found = YES;
      
      STAssertTrue([EXPECTED_SIGNATURE isEqualToString:param.value], @"Found signature parameter, but it is incorrect.  Expected \"%@\" but got \"%@\".", EXPECTED_SIGNATURE, param.value);
      
      break;
    }
  }
  
  STAssertTrue(found, @"No %@ parameter found.", SIGN_PARAMETER_KEY);
  
  
  // make sure it doesn't appear twice
  [self.signer configureSignParameterOnRequest:self.request];
  
  NSInteger countOfSignParams = 0;
  for (SRParameter *param in self.request.parameters.parameters) {
    if ([param.key isEqualToString:SIGN_PARAMETER_KEY]) {
      countOfSignParams++;
    }
  }
  
  STAssertEquals(1, countOfSignParams, @"%@ parameter shouldn't appear more than once with multiple calls to configureSignParameterOnRequest", SIGN_PARAMETER_KEY);
  
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
  
  NSLog(@"Signature: %@", signature);
  
  STAssertTrue([signature isEqualToString:EXPECTED_SIGNATURE], @"Signature incorrect :-(");
  
}

- (void)testUrlWithLowercaseDomain {
  
  STAssertTrue([[self.signer stringLowercaseUrl:self.request.url] isEqualToString:TEST_LOWERCASE_URL], @"urlWithLowercaseDomain didn't return correct string");
  
}

- (void)testUnencodedSignatureStringForRequest {
  
  NSString *signatureString = [self.signer unencodedSignatureStringForRequest:self.request];
  
  /*
  NSLog(@"---------------------------------");
  NSLog(@"signatureString: %@", signatureString);
  NSLog(@"---------------------------------");
  */
  
  STAssertTrue([signatureString isEqualToString:EXPECTED_UNENCODED_SIGNATURE_STRING], @"unencodedSignatureString incorrect.");
  
}

- (void)testHMAC_SHA1SignatureForText {
  
  NSString *plain = @"POST&http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople&FName%3DEdd%26email%3Dedd%40eddgrant.com%26email%3Dedd%40stretchr.com%26%7Ec%3Dthis-is-my-context-value%26%7Ekey%3Dabdh239d78c30f93jf88r0%26%7Esecret%3DthisIsMySecretValue";
  
  NSString *expectedSignature = @"0254006d89a17f8f1f82f4b191cc767dfbce0ec1";
  NSString *actualSignature = [self.signer HMAC_SHA1SignatureForText:plain];
  
  STAssertTrue([actualSignature isEqualToString:expectedSignature], @"Signature incorrect.  Expected: '%@' but was '%@'.", expectedSignature, actualSignature);
  
}

- (void)testHMAC_SHA1SignatureForText_2 {
  
  
  NSString *plain = @"POST&http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople&FName%3DEdd%26email%3Dedd%40eddgrant.com%26email%3Dedd%40stretchr.com%26lName%3DGrant%26%7Ec%3Dthis-is-my-context-value%26%7Ekey%3Dabdh239d78c30f93jf88r0%26%7Esecret%3DthisIsMySecretValue";
  
  NSString *expectedSignature = @"35b6d34742395160d3784b6b1a4e92e493a24453";
  NSString *actualSignature = [self.signer HMAC_SHA1SignatureForText:plain];
  
  STAssertTrue([actualSignature isEqualToString:expectedSignature], @"Signature incorrect.  Expected: '%@' but was '%@'.", expectedSignature, actualSignature);
  
}

@end

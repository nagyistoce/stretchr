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

- (void)testInit {
  
  SRRequestSigner *signer = [[SRRequestSigner alloc] init];
  
  STAssertNotNil(signer, @"Signer shouldn't be nil");
  
  [signer release];
  
}

- (void)testGenerateSignatureForRequest {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:TEST_METHOD credentials:creds];
  
  // add the parameters
  [request.parameters setValue:@"Edd" forKey:@"FName"];
  [request.parameters setValue:@"edd@eddgrant.com" forKey:@"email"];
  [request.parameters setValue:@"edd@stretchr.com" forKey:@"email"];
  [request.parameters setValue:@"Grant" forKey:@"lName"];

  [request release];
  [creds release];
  
}

@end

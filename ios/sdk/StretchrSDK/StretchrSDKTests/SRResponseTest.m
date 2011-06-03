//
//  SRResponseTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRResponseTest.h"
#import "SRResponse.h"

@implementation SRResponseTest

- (void)testInitWithResponse {
  
  NSHTTPURLResponse *urlResponse = [[NSHTTPURLResponse alloc] init];
  SRResponse *response = [[SRResponse alloc] initWithResponse:urlResponse];
  
  STAssertEqualObjects(urlResponse, response.urlResponse, @"urlResponse not set by constructor");
  STAssertTrue(response.success, @"success should be true");
  
  [urlResponse release];
  [response release];
  
}

- (void)testInitWithError {
  
  NSError *error = [[NSError alloc] init];
  SRResponse *response = [[SRResponse alloc] initWithError:error];
  
  STAssertEqualObjects(error, response.error, @"error not set by constructor");
  STAssertFalse(response.success, @"success should be false");
  
  [error release];
  [response release];
  
}

@end

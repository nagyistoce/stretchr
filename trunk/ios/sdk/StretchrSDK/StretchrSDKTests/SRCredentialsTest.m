//
//  SRCredentialsTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRCredentialsTest.h"
#import "SRCredentials.h"
#import "TestValues.h"

@implementation SRCredentialsTest

- (void)testInit {
  
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  
  STAssertEquals(TEST_KEY, creds.key, @"key should have been set");
  STAssertEquals(TEST_SECRET, creds.secret, @"secret should have been set");
  
  [creds release];
  
}

@end

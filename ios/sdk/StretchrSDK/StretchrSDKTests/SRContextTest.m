//
//  SRContextTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRContextTest.h"
#import "TestHelper.h"
#import "SRContext.h"

@implementation SRContextTest

- (void)testCurrentContext {
  
  STAssertNotNil([SRContext sharedInstance], @"[SRContext sharedInstance] should never be nil");
  STAssertEqualObjects([SRContext sharedInstance], [SRContext sharedInstance], @"Multiple calls to currentContext should always return the same object.");
  
}

- (void)testProperties {
  
  NSString *accountName = @"account-name";
  NSString *key = @"account-name";
  NSString *secret = @"account-name";
  
  [[SRContext sharedInstance] setAccountName:accountName];
  [[SRContext sharedInstance] setKey:key];
  [[SRContext sharedInstance] setSecret:secret];
  
  STAssertEqualStrings([[SRContext sharedInstance] accountName], accountName, @"accountName wrong");
  STAssertEqualStrings([[SRContext sharedInstance] key], key, @"key wrong");
  STAssertEqualStrings([[SRContext sharedInstance] secret], secret, @"secret wrong");
  
}

@end

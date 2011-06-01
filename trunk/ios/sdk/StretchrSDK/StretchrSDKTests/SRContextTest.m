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
#import "SRResource.h"

@implementation SRContextTest

- (void)testCurrentContext {
  
  STAssertNotNil([SRContext sharedInstance], @"[SRContext sharedInstance] should never be nil");
  STAssertEqualObjects([SRContext sharedInstance], [SRContext sharedInstance], @"Multiple calls to currentContext should always return the same object.");
  
}

- (void)testPropertySetter {
  
  NSString *accountName = @"account-name";
  NSString *key = @"account-name";
  NSString *secret = @"account-name";
  
  [[SRContext sharedInstance] setAccountName:nil];
  [[SRContext sharedInstance] setCredentials:nil];
  
  [[SRContext sharedInstance] setAccountName:accountName key:key secret:secret];
  
  STAssertEqualStrings([[SRContext sharedInstance] accountName], accountName, @"accountName wrong");
  STAssertEqualStrings([[SRContext sharedInstance].credentials key], key, @"key wrong");
  STAssertEqualStrings([[SRContext sharedInstance].credentials secret], secret, @"secret wrong");
  
}

- (void)testRootURL {
  
  NSString *accountName = @"account-name";
  NSString *key = @"account-name";
  NSString *secret = @"account-name";
  
  [[SRContext sharedInstance] setAccountName:accountName key:key secret:secret];
  
  NSString *rootURL = [[SRContext sharedInstance] rootURL];
  
  STAssertEqualStrings(rootURL, @"http://account-name.xapi.co", @"rootURL wrong");
  
}

- (void)testURLForResource {
  
  NSString *accountName = @"account-name";
  NSString *key = @"account-name";
  NSString *secret = @"account-name";
  
  [[SRContext sharedInstance] setAccountName:accountName key:key secret:secret];
  
  SRResource *resource = [[SRResource alloc] initWithPath:@"/people/1/comments/1"];
  
  NSURL *urlForResource = [[SRContext sharedInstance] URLForResource:resource];
  
  STAssertEqualStrings([urlForResource absoluteString], @"http://account-name.xapi.co/people/1/comments/1", @"URLForResource wrong"); 
  
  [resource release];
  
}

@end

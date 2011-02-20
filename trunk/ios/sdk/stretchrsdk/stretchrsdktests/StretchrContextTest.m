//
//  StretchrContextTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrContextTest.h"
#import "TestHelpers.h"

@implementation StretchrContextTest

- (void)setUp {
  
  NSString *accountName = @"account-name";
  NSString *publicKey = @"public-key";
  NSString *privateKey = @"private-key";
  
  testContext = [[StretchrContext alloc] initWithAccountName:accountName
                                                                publicKey:publicKey
                                                               privateKey:privateKey];
  
}

- (void)tearDown {
  
  [testContext release];
  testContext = nil;
  
}

- (void)testInit {
  
  NSString *accountName = @"account-name";
  NSString *publicKey = @"public-key";
  NSString *privateKey = @"private-key";
  
  StretchrContext *context = [[StretchrContext alloc] initWithAccountName:accountName
                                                                publicKey:publicKey
                                                               privateKey:privateKey];
  
  STAssertStringsEqual(context.accountName, accountName, @"context.accountName incorrect");
  STAssertStringsEqual(context.publicKey, publicKey, @"context.publicKey incorrect");
  STAssertStringsEqual(context.privateKey, privateKey, @"context.privateKey incorrect");
  
  [context release];
  
}

#pragma mark - URLs

- (void)testServerDomain {
  
  [testContext setUseSsl:NO];
  STAssertStringsEqual([testContext serverDomain], @"http://account-name.stretchr.com", @"Return of serverDomain incorrect (http)");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext serverDomain], @"https://account-name.stretchr.com", @"Return of serverDomain incorrect (https)");
  
}

- (void)testUrlForResourceWithNewResource { 
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags"];
  
  [testContext setUseSsl:NO];
  NSLog([testContext urlForResource:resource]);
  STAssertStringsEqual([testContext urlForResource:resource], @"http://account-name.stretchr.com/people/123/tags", @"Return of urlForResource incorrect");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext urlForResource:resource], @"https://account-name.stretchr.com/people/123/tags", @"Return of urlForResource incorrect");
  
  [resource release];
  
}

- (void)testUrlForResourceWithExistingResource { 
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags" andId:@"lemon"];
  
  [testContext setUseSsl:NO];
  STAssertStringsEqual([testContext urlForResource:resource], @"http://account-name.stretchr.com/people/123/tags/lemon", @"Return of urlForResource incorrect");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext urlForResource:resource], @"https://account-name.stretchr.com/people/123/tags/lemon", @"Return of urlForResource incorrect");
  
  [resource release];
  
}

@end

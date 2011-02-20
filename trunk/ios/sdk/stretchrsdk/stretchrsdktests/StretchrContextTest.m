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

@end

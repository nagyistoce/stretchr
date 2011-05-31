//
//  SRContext.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRContext.h"


@implementation SRContext
@synthesize accountName, key, secret;

SingletonImplementation(SRContext);

- (void)setAccountName:(NSString*)theAccountName key:(NSString*)theKey secret:(NSString*)theSecret {
  
  [self setAccountName:theAccountName];
  [self setKey:theKey];
  [self setSecret:theSecret];
  
}

@end

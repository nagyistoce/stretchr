//
//  SRCredentials.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRCredentials.h"


@implementation SRCredentials
@synthesize key, secret;

- (id)initWithKey:(NSString*)theKey secret:(NSString*)theSecret {
  
  if ((self = [super init])) {
    
    self.key = theKey;
    self.secret = theSecret;
    
  }
  return self;
  
}

- (void)dealloc {
  
  self.key = nil;
  self.secret = nil;
  
  [super dealloc];
}

@end

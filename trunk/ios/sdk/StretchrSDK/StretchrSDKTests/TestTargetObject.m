//
//  TestTargetObject.m
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "TestTargetObject.h"
#import "SRResponse.h"

@implementation TestTargetObject
@synthesize lastResponse;

- (void)dealloc {
  
  self.lastResponse = nil;
  
  [super dealloc];
}

- (void)processResponse:(SRResponse*)response {
  self.lastResponse = response;
}

@end

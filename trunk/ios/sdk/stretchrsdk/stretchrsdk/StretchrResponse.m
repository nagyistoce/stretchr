//
//  StretchrResponse.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResponse.h"


@implementation StretchrResponse
@synthesize worked, status, context, errors, response;

- (void)dealloc {
  
  self.errors = nil;
  self.context = nil;
  
  [super dealloc];
}

@end

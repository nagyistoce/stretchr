//
//  SRResource.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRResource.h"


@implementation SRResource
@synthesize path;

- (id)initWithPath:(NSString*)thePath {
  if ((self = [super init])) {
    
    self.path = thePath;
    
  }
  return self;
}

@end

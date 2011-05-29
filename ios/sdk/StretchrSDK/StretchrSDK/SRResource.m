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
@synthesize parameters;

- (id)init {
  if ((self = [super init])) {
    
    // create a container for the parameters
    SRParameterCollection *paramsCollection = [[SRParameterCollection alloc] init];
    self.parameters = paramsCollection;
    [paramsCollection release];
    
  }
  return self;
}

- (id)initWithPath:(NSString*)thePath {
  
  if ((self = [self init])) {
    // set the path
    self.path = thePath;
  }
  return self;
  
}

- (void)dealloc {
  self.path = nil;
  self.parameters = nil;
  [super dealloc];
}


@end

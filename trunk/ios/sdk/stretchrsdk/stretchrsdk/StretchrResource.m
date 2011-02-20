//
//  StretchrResource.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResource.h"


@implementation StretchrResource
@synthesize path;
@synthesize properties;

- (id)initWithPath:(NSString*)resourcePath {
  
  // create empty property holder
  NSMutableDictionary *props = [[NSMutableDictionary alloc] initWithCapacity:4];
  
  if ((self = [self initWithPath:resourcePath andProperties:props])) {
    // init
  }
  
  [props release];
  return self;
  
  
}
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)props {
  
  if ((self = [self init])) {
    
    self.path = resourcePath;
    self.properties = props;
    
  }
  return self;
  
}

- (void)dealloc {
  
  self.path = nil;
  
  [super dealloc];
}

@end

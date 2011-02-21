//
//  StretchrHttpResource.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrHttpResource.h"

/**
 Represents a low-level HTTP resource.  This class is the base of StretchrResource and StretchrResourceCollection classes.
 */
@implementation StretchrHttpResource

@synthesize path;

- (id)initWithPath:(NSString*)httpResourcePath {
  
  if ((self = [super init])) {
    self.path = httpResourcePath;
  }
  
  return self;
  
}

- (void)dealloc {
  self.path = nil;
  [super dealloc];
}

#pragma mark - URLs

- (NSString*)fullRelativePathUrl {
  return self.path;
}

@end

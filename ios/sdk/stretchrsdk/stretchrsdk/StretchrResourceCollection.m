//
//  StretchrResourceCollection.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResourceCollection.h"


@implementation StretchrResourceCollection

@synthesize totalLength, startIndex, endIndex;
@synthesize resources;

- (void)dealloc {
  
  self.resources = nil;
  
  [super dealloc];
}

@end

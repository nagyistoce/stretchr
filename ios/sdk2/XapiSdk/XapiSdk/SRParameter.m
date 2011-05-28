//
//  SRParameter.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRParameter.h"


@implementation SRParameter
@synthesize key, value;

- (id)initWithKey:(NSString *)theKey andValue:(NSString *)theValue {
  if ((self = [super init])) {
    self.key = theKey;
    self.value = theValue;
  }
  return self;
}

- (void)dealloc {
  
  self.key = nil;
  self.value = nil;
  
  [super dealloc];
}

- (NSComparisonResult)compare:(id)inObject {
  
	NSComparisonResult result = [self.key compare:[(SRParameter *)inObject key]];
	
	if (result == NSOrderedSame) {
		result = [self.value compare:[(SRParameter *)inObject value]];
	}
  
	return result;
  
}

@end

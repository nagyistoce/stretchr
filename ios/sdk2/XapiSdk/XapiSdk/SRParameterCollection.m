//
//  SRParameterCollection.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRParameterCollection.h"


@implementation SRParameterCollection
@synthesize parameters;

- (id)init {
  if ((self = [super init])) {
    
    NSMutableArray *parametersArray = [[NSMutableArray alloc] init];
    self.parameters = parametersArray;
    [parametersArray release];
    
  }
  return self;
}

- (void)dealloc {
  
  self.parameters = nil;
  
  [super dealloc];
}

- (void)addValue:(NSString*)value forKey:(NSString*)key {
  
  SRParameter *newParam = [[SRParameter alloc] initWithKey:key andValue:value];
  [self.parameters addObject:newParam];
  [newParam release];
  
}

- (SRParameter*)objectAtIndex:(NSUInteger)index {
  return (SRParameter*)[self.parameters objectAtIndex:index];
}

- (NSUInteger)count {
  return [self.parameters count];
}

@end

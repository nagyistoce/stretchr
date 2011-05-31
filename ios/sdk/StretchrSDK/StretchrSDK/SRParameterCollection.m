//
//  SRParameterCollection.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
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

- (NSString*)orderedParameterString {
  
  // sort the parameters
  [self.parameters sortUsingSelector:@selector(compare:)];
  
  // generate the string
  NSMutableString *paramString = [[[NSMutableString alloc] init] autorelease];
  
  NSInteger i = 0;
  NSInteger l = [self.parameters count];
  SRParameter *param = nil;
  
  for (; i < l; i++) {
    
    param = [self.parameters objectAtIndex:i];
    
    [paramString appendString:[param URLParameterString]];
    
    if (i < l-1) {
      [paramString appendString:@"&"];
    }
  }
  
  return paramString;
  
}

- (SRParameter*)firstParameterWithKey:(NSString*)key {
  
  for (SRParameter *param in self.parameters) {
   
    if ([param.key isEqualToString:key])
      return param;
    
  }
  
  return nil;
  
}

- (void)addValue:(NSString*)value forKey:(NSString*)key {
  
  SRParameter *newParam = [[SRParameter alloc] initWithKey:key andValue:value];
  [self.parameters addObject:newParam];
  [newParam release];
  
}

- (void)setSingleValue:(NSString*)value forKey:(NSString*)key {
  
  // does a parameter for this key already exist?
  SRParameter *existingParam = [self firstParameterWithKey:key];
  
  if (existingParam == nil) {
    // add it fresh
    [self addValue:value forKey:key];
  } else {
    // modify the value
    [existingParam setValue:value];
  }
  
}

- (SRParameter*)objectAtIndex:(NSUInteger)index {
  return (SRParameter*)[self.parameters objectAtIndex:index];
}

- (NSUInteger)count {
  return [self.parameters count];
}

@end

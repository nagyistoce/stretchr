//
//  StretchrResource.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrResource.h"
#import "StretchrConstants.h"

@implementation StretchrResource
@synthesize properties;

#pragma mark - init

- (id)init {
  
  if ((self = [self initWithPath:nil andProperties:nil andId:nil])) {
    
  }
  return self;
  
}

- (id)initWithPath:(NSString*)resourcePath {

  if ((self = [self initWithPath:resourcePath andProperties:nil andId:nil])) {
  }
  
  return self;
  
}

- (id)initWithPath:(NSString*)resourcePath andId:(NSString *)resId {
  
  if ((self = [self initWithPath:resourcePath andProperties:nil andId:resId])) {
  }
  
  return self;
  
}

- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)props {
  
  if ((self = [self initWithPath:resourcePath andProperties:props andId:nil])) {
  }
  
  return self;
  
}

- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)props andId:(NSString *)resId {
  
  if ((self = [super initWithPath:resourcePath])) {
    
    // make sure we have a properties dictionary
    if (props == nil) {
      NSMutableDictionary *emptyProps = [[NSMutableDictionary alloc] initWithCapacity:0];
      self.properties = emptyProps;
      [emptyProps release];
    } else {
      self.properties = props;
    }
    
    // activly set the ID
    [self setResourceId:resId];
    
  }
  return self;
  
}

- (void)dealloc {

  self.properties = nil;
  
  [super dealloc];
}

#pragma mark - State

- (NSString*)resourceId {
  return [self.properties valueForKey:StretchrResourceIdPropertyKey];
}
- (void)setResourceId:(NSString*)resId {
  [self.properties setValue:resId forKey:StretchrResourceIdPropertyKey];
}

- (BOOL)exists {
  
  return self.resourceId != nil;
  
}

- (NSString*)fullRelativePath {
  
  NSString *idBit = @"";
  
  if ([self exists]) {
    idBit = [NSString stringWithFormat:@"/%@", self.resourceId];
  }
  
  return [NSString stringWithFormat:@"%@%@", [super fullRelativePathUrl], idBit];
  
}

#pragma mark - Data

- (NSString*)postBodyStringIncludingId:(BOOL)includeId {
  
  NSMutableString *postBody = [[[NSMutableString alloc] init] autorelease];
  
  // cycle through the properties
  NSString *key = nil;
  NSArray *propertyKeys = [self.properties allKeys];
  for (NSInteger i = 0, l = [propertyKeys count]; i < l; i++) {
    
    key = [propertyKeys objectAtIndex:i];
    
    if (!includeId && [key isEqualToString:StretchrResourceIdPropertyKey])
      continue;
    
    // add this property
    [postBody appendFormat:@"%@=%@&", key, [self.properties valueForKey:key]];
    
  }
  
  // trim off the last & if there is one
  if ([[postBody substringFromIndex:[postBody length] - 1] isEqualToString:@"&"]) {
    return [postBody substringToIndex:[postBody length] - 1];
  } else {
    return postBody;
  }
  
}

@end

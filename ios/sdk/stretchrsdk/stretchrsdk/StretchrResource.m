//
//  StretchrResource.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrResource.h"

@implementation StretchrResource
@synthesize resourceId;
@synthesize properties;

#pragma mark - init

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
    
    self.resourceId = resId;
    
    // make sure we have a properties dictionary
    if (props == nil) {
      NSMutableDictionary *emptyProps = [[NSMutableDictionary alloc] initWithCapacity:0];
      self.properties = emptyProps;
      [emptyProps release];
    } else {
      self.properties = props;
    }
    
  }
  return self;
  
}

- (void)dealloc {

  self.properties = nil;
  self.resourceId = nil;
  
  [super dealloc];
}

#pragma mark - State

- (BOOL)exists {
  
  return self.resourceId != nil;
  
}

- (NSString*)fullRelativePath {
  
  NSString *idBit = @"";
  
  if ([self exists]) {
    idBit = [NSString stringWithFormat:@"/%@", self.resourceId];
  }
  
  return [NSString stringWithFormat:@"%@%@", [super fullRelativePath], idBit];
  
}

@end

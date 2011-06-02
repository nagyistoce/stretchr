//
//  SRResponse.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRResponse.h"

@implementation SRResponse
@synthesize urlResponse;
@synthesize error;
@synthesize connection;

- (id)initWithResponse:(NSURLResponse*)theResponse {
  if ((self = [super init])) {
    
    self.urlResponse = theResponse;
    
  }
  return self;
}

- (id)initWithError:(NSError*)theError {
  if ((self = [super init])) {
    self.error = theError;
  }
  return self;
}

- (void)dealloc {
  
  self.urlResponse = nil;
  self.error = nil;
  self.connection = nil;
  
  [super dealloc];
}

- (BOOL)success {
  return self.error == nil;
}

@end

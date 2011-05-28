//
//  SRRequest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRRequest.h"
#import "SRCredentials.h"

@implementation SRRequest
@synthesize url;
@synthesize parameters = parameters_;
@synthesize method;
@synthesize credentials;

- (id)init {
  if ((self = [super init])) {
    
    // parameters start off nil
    parameters_ = nil;
    
  }
  return self;
}

- (id)initWithUrl:(NSURL*)theUrl method:(SRRequestMethod)theMethod credentials:(SRCredentials*)theCredentials {
  if ((self = [self init])) {
    
    self.url = theUrl;
    self.method = theMethod;
    self.credentials = theCredentials;
    
  }
  return self;
}

- (void)dealloc {
  
  self.url = nil;
  self.parameters = nil;
  self.credentials = nil;
  
  [super dealloc];
}

#pragma mark - Parameters

/**
 Gets (or creates) dictionary to hold parameters
 */
- (NSMutableDictionary*)parameters {
  
  if (parameters_ == nil) {
    
    NSMutableDictionary *parametersDictionay = [[NSMutableDictionary alloc] init];
    self.parameters = parametersDictionay;
    [parametersDictionay release];
    
  }
  
  return parameters_;
  
}

- (BOOL)hasParameters {
  return parameters_ != nil;
}

@end

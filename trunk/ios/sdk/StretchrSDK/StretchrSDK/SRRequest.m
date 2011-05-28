//
//  SRRequest.m
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRRequest.h"
#import "SRCredentials.h"
#import "SRParameter.h"

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
    
    // TODO: make creds read only
    
    // add key parameter
    [self.parameters addValue:self.credentials.key forKey:KEY_PARAMETER_KEY];
    
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
- (SRParameterCollection*)parameters {
  
  if (parameters_ == nil) {
    
    SRParameterCollection *parametersCollection = [[SRParameterCollection alloc] init];
    self.parameters = parametersCollection;
    [parametersCollection release];
    
  }
  
  return parameters_;
  
}

- (BOOL)hasParameters {
  return parameters_ != nil;
}

@end

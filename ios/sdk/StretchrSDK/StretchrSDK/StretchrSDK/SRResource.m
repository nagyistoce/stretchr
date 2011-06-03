//
//  SRResource.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRResource.h"
#import "SRConnection.h"

@implementation SRResource
@synthesize path;
@synthesize parameters;
@synthesize resourceId;

- (id)init {
  if ((self = [super init])) {
    
    // create a container for the parameters
    SRParameterCollection *paramsCollection = [[SRParameterCollection alloc] init];
    self.parameters = paramsCollection;
    [paramsCollection release];
    
  }
  return self;
}

- (id)initWithPath:(NSString*)thePath {
  
  if ((self = [self init])) {
    // set the path
    self.path = thePath;
  }
  return self;
  
}

- (id)initWithPath:(NSString*)thePath resourceId:(NSString*)theResourceId {
  
  if ((self = [self initWithPath:thePath])) {
    // set the resource ID
    self.resourceId = theResourceId;
  }
  return self;
  
}

- (void)dealloc {
  self.path = nil;
  self.parameters = nil;
  self.resourceId = nil;
  [super dealloc];
}

#pragma mark - Parameters

- (void)addParameterValue:(NSString*)value forKey:(NSString*)key {
  [self.parameters addValue:value forKey:key];
}

- (void)setParameterValue:(NSString*)value forKey:(NSString*)key {
  [self.parameters setSingleValue:value forKey:key];
}

- (NSString*)firstValueForKey:(NSString*)key {
  
  SRParameter *param = [self.parameters firstParameterWithKey:key];
  
  if (param) {
    return param.value;
  } else {
    return nil;
  }
  
}

#pragma mark - Resource ID

- (BOOL)hasResourceId {
  return [self resourceId] != nil;
}

#pragma mark - Actions

- (SRConnection*)createConnectionForRequest:(NSURLRequest*)request withOriginalRequest:(SRRequest *)originalRequest target:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately {
  
  SRConnection *connection = [[[SRConnection alloc] initWithRequest:request originalRequest:originalRequest target:target selector:selector] autorelease];
  
  if (startImmediately) {
    [connection start];
  }
  
  return connection;
  
}

- (SRConnection*)createThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately {
  
  SRRequest *originalRequest = [SRRequestFactory requestToCreateResource:self];
  NSURLRequest *request = [originalRequest makeSignedUrlRequest];
  
  return [self createConnectionForRequest:request
                      withOriginalRequest:originalRequest
                                   target:target 
                                 selector:selector 
                         startImmediately:startImmediately];
}

- (SRConnection*)readThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately {
  
  SRRequest *originalRequest = [SRRequestFactory requestToReadResource:self];
  NSURLRequest *request = [originalRequest makeSignedUrlRequest];
  
  return [self createConnectionForRequest:request
                      withOriginalRequest:originalRequest
                                   target:target 
                                 selector:selector 
                         startImmediately:startImmediately];
  
}

- (SRConnection*)updateThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately {
  
  SRRequest *originalRequest = [SRRequestFactory requestToUpdateResource:self];
  NSURLRequest *request = [originalRequest makeSignedUrlRequest];
  
  return [self createConnectionForRequest:request
                      withOriginalRequest:originalRequest
                                   target:target 
                                 selector:selector 
                         startImmediately:startImmediately];
  
}

- (SRConnection*)deleteThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately {
  
  SRRequest *originalRequest = [SRRequestFactory requestToDeleteResource:self];
  NSURLRequest *request = [originalRequest makeSignedUrlRequest];
  
  return [self createConnectionForRequest:request
                      withOriginalRequest:originalRequest
                                   target:target 
                                 selector:selector 
                         startImmediately:startImmediately];
  
}

@end

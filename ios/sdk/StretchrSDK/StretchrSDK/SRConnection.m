//
//  SRConnection.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRConnection.h"
#import "SRResponse.h"

@implementation SRConnection
@synthesize isBusy;
@synthesize request = request_;
@synthesize underlyingConnection = underlyingConnection_;
@synthesize target, selector;

- (id)init {
  [NSException raise:@"InvalidMethod" format:@"You must use initWithRequest:"];
  return nil;
}

- (id)initWithRequest:(NSURLRequest*)theRequest {
  if ((self = [super init])) {
    
    request_ = theRequest;
    [request_ retain];
    
    // create the underlying connection
    underlyingConnection_ = [NSURLConnection connectionWithRequest:request_ delegate:self];
    [underlyingConnection_ retain];
    
    // who's busy?
    isBusy = NO;
    
  }
  return self;
}

- (id)initWithRequest:(NSURLRequest *)theRequest target:(id)theTarget selector:(SEL)theSelector {
  if ((self = [self initWithRequest:theRequest])) {
    
    self.target = theTarget;
    self.selector = theSelector;
    
  }
  return self;
}

- (void)dealloc {
  
  [request_ release];
  [underlyingConnection_ release];
  
  // nil out the other bits too
  self.target = nil;
  self.selector = nil;
  
  [super dealloc];
}

#pragma mark - Actions

- (void)start {
  self.isBusy = YES;
  [self.underlyingConnection start];
}

- (void)cancel {
  [self.underlyingConnection cancel];
  self.isBusy = NO;
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)urlResponse {
  
  self.isBusy = NO;
  
  SRResponse *response = [[SRResponse alloc] init];
  
  // call the selector
  if ([self.target respondsToSelector:self.selector]) {
    [self.target performSelector:self.selector withObject:response];
  }
  
  [response release];
  
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

  SRResponse *response = [[SRResponse alloc] initWithError:error];
  
  // call the selector
  if ([self.target respondsToSelector:self.selector]) {
    [self.target performSelector:self.selector withObject:response];
  }
  
  [response release];
  
}

@end

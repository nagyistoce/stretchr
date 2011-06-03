//
//  SRConnection.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRConnection.h"
#import "SRResponse.h"

@implementation SRConnection
@synthesize isBusy;
@synthesize request = request_;
@synthesize originalRequest;
@synthesize underlyingConnection = underlyingConnection_;
@synthesize target, selector;
@synthesize receivedData;

- (id)init {
  [NSException raise:@"InvalidMethod" format:@"You must use initWithRequest:"];
  return nil;
}

- (id)initWithRequest:(NSURLRequest*)theRequest originalRequest:(SRRequest*)theOriginalRequest {
  if ((self = [super init])) {
    
    // save the original request
    self.originalRequest = theOriginalRequest;
    
    // save the request
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

- (id)initWithRequest:(NSURLRequest *)theRequest originalRequest:(SRRequest*)theOriginalRequest target:(id)theTarget selector:(SEL)theSelector {
  if ((self = [self initWithRequest:theRequest originalRequest:theOriginalRequest])) {
    
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
  self.originalRequest = nil;
  self.receivedData = nil;
  
  [super dealloc];
}

#pragma mark - Actions

- (void)start {
  self.isBusy = YES;
  [self retain];
  [self.underlyingConnection start];
}

- (void)cancel {
  [self.underlyingConnection cancel];
  self.isBusy = NO;
  [self release];
}

#pragma mark - NSURLConnection

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  // save the data that just came in
  
  if (!self.receivedData) {
    
    NSMutableData *receivedDataStore = [[NSMutableData alloc] initWithData:data];
    self.receivedData = receivedDataStore;
    [receivedDataStore release];
    
  } else {
    [self.receivedData appendData:data];
  }
  
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)urlResponse {
  
  // finished
  self.isBusy = NO;
  [self release];
  
  SRResponse *response = [[SRResponse alloc] initWithResponse:urlResponse];
  
  // set this connection
  [response setConnection:self];
  
  // set the data
  [response setData:[NSData dataWithData:self.receivedData]];
  
  // call the selector
  if ([self.target respondsToSelector:self.selector]) {
    [self.target performSelector:self.selector withObject:response];
  }
  
  [response release];
  
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

  // finished
  self.isBusy = NO;
  [self release];
  
  SRResponse *response = [[SRResponse alloc] initWithError:error];
  
  // set this connection
  [response setConnection:self];
  
  // set the data
  [response setData:[NSData dataWithData:self.receivedData]];
  
  // call the selector
  if ([self.target respondsToSelector:self.selector]) {
    [self.target performSelector:self.selector withObject:response];
  }
  
  [response release];
  
}

@end

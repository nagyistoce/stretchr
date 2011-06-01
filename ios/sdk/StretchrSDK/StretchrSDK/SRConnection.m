//
//  SRConnection.m
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRConnection.h"


@implementation SRConnection
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
  
  [super dealloc];
}

@end

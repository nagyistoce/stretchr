//
//  SRRequest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRRequest.h"
#import "SRCredentials.h"
#import "SRParameter.h"
#import "SRRequestSigner.h"
#import "SRHttpHelper.h"

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
    
    // add key parameter
    [self.parameters addValue:self.credentials.key forKey:KEY_PARAMETER_KEY];
    NSLog(@"key parameter added");
    
  }
  return self;
}

- (void)dealloc {
  
  self.url = nil;
  self.parameters = nil;
  self.credentials = nil;
  
  [super dealloc];
}

#pragma mark - NSURLRequest integration

- (NSURLRequest*)makeSignedUrlRequest {
  
  // sign the request
  SRRequestSigner *signer = [[SRRequestSigner alloc] init];
  [signer configureSignParameterOnRequest:self];
  [signer release];
  
  // build the NSURLRequest
  NSMutableURLRequest *urlRequest = [[[NSMutableURLRequest alloc] initWithURL:self.url] autorelease];
  
  // set the correct HTTP method
  [urlRequest setHTTPMethod:[SRHttpHelper methodStringForMethod:self.method]];
  
  // add the data
  NSString *postDataString = [self.parameters orderedParameterString];
  
  if (SRRequestMethodHasPostBody([self method])) {
    
    NSData *postData = [postDataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [urlRequest setHTTPBody:postData];
    
  } else {
    
    // append the parameters to the URL
    [urlRequest setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlRequest.URL, postDataString]]];
    
  }
  
  // return the new request
  return urlRequest;
  
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

//
//  StretchrContext.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrContext.h"
#import "StretchrResource.h"
#import "StretchrResponse.h"

@implementation StretchrContext
@synthesize delegate, requestDelegate, connectionDelegate;
@synthesize accountName, publicKey, privateKey;
@synthesize domain, useSsl, dataType;

#pragma mark - init

- initWithDelegate:(id<StretchrContextDelegate>)contextDelegate AccountName:(NSString*)accName publicKey:(NSString*)pubKey privateKey:(NSString*)privKey {
  
  if ((self = [self init])) {
    
    // set properties
    self.accountName = accName;
    self.publicKey = pubKey;
    self.privateKey = privKey;
    
    // set the defaults
    self.domain = @"stretchr.com";
    self.dataType = @"json";
    
    // set default delegate to self
    self.delegate = contextDelegate;
    self.requestDelegate = self;
    self.connectionDelegate = self;
    
    // empty holder for response data
    currentResponseData_ = [[NSMutableData alloc] init];
    
  }
  return self;
  
}

- (void)dealloc {
  
  [currentResponseData_ release];
  currentResponseData_ = nil;
  [currentConnection_ release];
  currentConnection_ = nil;
  
  self.accountName = nil;
  self.privateKey = nil;
  self.publicKey = nil;
  self.domain = nil;
  self.dataType = nil;
  
  self.requestDelegate = nil;
  self.connectionDelegate = nil;
  
  [super dealloc];
  
}

#pragma mark - Http

- (NSString*)httpMethodStringFromStretchrHttpMethod:(StretchrHttpMethod)httpMethod {
  
  static NSString *postHttpMethod = @"POST";
  static NSString *putHttpMethod = @"PUT";
  static NSString *deleteHttpMethod = @"DELETE";
  static NSString *getHttpMethod = @"GET";
  
  switch (httpMethod) {
    case StretchrHttpMethodPOST:
      return postHttpMethod;
      break;
    case StretchrHttpMethodGET:
      return getHttpMethod;
      break;
    case StretchrHttpMethodPUT:
      return putHttpMethod;
      break;
    case StretchrHttpMethodDELETE:
      return deleteHttpMethod;
      break;
  }
  
  [NSException raise:@"UnknownHttpMethod" format:@"Unknown HTTP method."];
  return nil;
  
}

#pragma mark - URLs

- (NSString*)host {
  
  NSString *host = [NSString stringWithFormat:@"%@://%@.%@",
          self.useSsl ? @"https" : @"http",
          self.accountName,
          self.domain];
  
  // allow the delegate to change the host if they wish
  if ([self.delegate respondsToSelector:@selector(stretchrContext:willUseHost:)]) {
    host = [self.delegate stretchrContext:self willUseHost:host];
  }
  
  return host;
  
}

- (NSString*)urlForResource:(StretchrResource*)resource {
  
  NSString *url;
  
  if ([resource exists]) {
    url = [NSString stringWithFormat:@"%@%@/%@.%@", [self host], [resource fullRelativePathUrl], [resource resourceId], self.dataType];
  } else {
    url = [NSString stringWithFormat:@"%@%@.%@", [self host], [resource fullRelativePathUrl], self.dataType];
  }
  
  // allow the delegate the chance to modify the URL if it wishes
  if ([self.delegate respondsToSelector:@selector(stretchrContext:urlForResource:willUseUrl:)]) {
    url = [self.delegate stretchrContext:self urlForResource:resource willUseUrl:url];
  }
  
  return url;
  
}

#pragma mark - Creating NSURLRequest objects

- (NSURLRequest*)createUrlRequestToCreateResource:(StretchrResource*)resource {
  
  // create the request
  NSMutableURLRequest *request = [self.requestDelegate stretchrContext:self urlRequestForResource:resource];
  
  // configure it
  [self.requestDelegate stretchrContext:self configureUrlRequest:request toCreateResource:resource];
  
  // finish configuring it
  [self.requestDelegate stretchrContext:self finishConfigurationForRequest:request];
  
  // return it
  return request;
  
}

- (NSURLRequest*)createUrlRequestToReadResource:(StretchrResource*)resource {

  // create the request
  NSMutableURLRequest *request = [self.requestDelegate stretchrContext:self urlRequestForResource:resource];
  
  // configure it
  [self.requestDelegate stretchrContext:self configureUrlRequest:request toReadResource:resource];
  
  // finish configuring it
  [self.requestDelegate stretchrContext:self finishConfigurationForRequest:request];
  
  // return it
  return request;
  
}

- (NSURLRequest*)createUrlRequestToUpdateResource:(StretchrResource*)resource {

  // create the request
  NSMutableURLRequest *request = [self.requestDelegate stretchrContext:self urlRequestForResource:resource];
  
  // configure it
  [self.requestDelegate stretchrContext:self configureUrlRequest:request toUpdateResource:resource];
  
  // finish configuring it
  [self.requestDelegate stretchrContext:self finishConfigurationForRequest:request];
  
  // return it
  return request;
  
}

- (NSURLRequest*)createUrlRequestToDeleteResource:(StretchrResource*)resource {

  // create the request
  NSMutableURLRequest *request = [self.requestDelegate stretchrContext:self urlRequestForResource:resource];
  
  // configure it
  [self.requestDelegate stretchrContext:self configureUrlRequest:request toDeleteResource:resource];
  
  // finish configuring it
  [self.requestDelegate stretchrContext:self finishConfigurationForRequest:request];
  
  // return it
  return request;
  
}

#pragma mark - StretchrContextRequestDelegate methods

- (NSMutableURLRequest*)stretchrContext:(StretchrContext*)context urlRequestForResource:(StretchrResource*)resource {
  
  NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
  
  // set common headers
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  
  return request;
  
}

- (void)stretchrContext:(StretchrContext*)context finishConfigurationForRequest:(NSMutableURLRequest*)urlRequest {
  
  // set the content length header
  [urlRequest setValue:[NSString stringWithFormat:@"%d", [urlRequest.HTTPBody length]] forHTTPHeaderField:@"Content-Length"];
  
}

/**
 Configures an existing NSURLRequest object to create the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toCreateResource:(StretchrResource*)resource {
  
  [urlRequest setHTTPMethod:[context httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodPOST]];
  [urlRequest setURL:[NSURL URLWithString:[context urlForResource:resource]]];
  [urlRequest setHTTPBody:[[resource postBodyStringIncludingId:YES] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];

}

/**
 Configures an existing NSURLRequest object to read the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toReadResource:(StretchrResource*)resource {
 
  [urlRequest setHTTPMethod:[context httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodGET]];
  NSURL *url = [NSURL URLWithString:[context urlForResource:resource]];
  url = [NSURL URLWithString:[NSString stringWithFormat:@"?%@", [resource postBodyStringIncludingId:NO]] relativeToURL:url];  
  [urlRequest setURL:url];
  
}

/**
 Configures an existing NSURLRequest object to update the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toUpdateResource:(StretchrResource*)resource {
  
  [urlRequest setHTTPMethod:[context httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodPUT]];
  [urlRequest setURL:[NSURL URLWithString:[context urlForResource:resource]]];
  [urlRequest setHTTPBody:[[resource postBodyStringIncludingId:NO] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
  
  // set the content length header
  [urlRequest setValue:[NSString stringWithFormat:@"%d", [urlRequest.HTTPBody length]] forHTTPHeaderField:@"Content-Length"];
  
}

/**
 Configures an existing NSURLRequest object to delete the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toDeleteResource:(StretchrResource*)resource {
  
  [urlRequest setHTTPMethod:[context httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodDELETE]];
  NSURL *url = [NSURL URLWithString:[context urlForResource:resource]];
  url = [NSURL URLWithString:[NSString stringWithFormat:@"?%@", [resource postBodyStringIncludingId:NO]] relativeToURL:url];  
  [urlRequest setURL:url];
  
}

#pragma mark - StretchrContextConnectionDelegate methods

- (NSURLConnection*)stretchrContext:(StretchrContext*)context needsConnectionForRequest:(NSURLRequest*)request {
  
  if (currentConnection_ != nil) {
    [currentConnection_ release];
    currentConnection_ = nil;
  }
  
  NSURLRequest *activeRequest = [NSURLRequest requestWithURL:[request URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
  currentConnection_ = [[NSURLConnection alloc] initWithRequest:activeRequest delegate:self];
  
  if (!currentConnection_) {
    
    // TODO: Fix this implemntation
    // connection failed :-(
    abort();
    
  }
  
  return currentConnection_;
  
}

#pragma mark - NSURLConnectionDelegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  
  // reset the length, as the data will be passed in its entireity
  [currentResponseData_ setLength:0];
  
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  
  // add the data we just got
  [currentResponseData_ appendData:data];
  
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  // no longer busy
  isWorking_ = NO;
  
  // build the response
  StretchrResponse *response = [[StretchrResponse alloc] init];
  
  // TODO: read the data and build the response
  NSLog(@"TODO: Read and process: %@", [currentResponseData_ description]);
  
  [self.delegate stretchrContext:self connectionDidFinishLoading:connection withResponse:(StretchrResponse*)response];
  
  // clean up objects
  [response release];
  [currentResponseData_ release];
  [currentConnection_ release];
  
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  
  // no longer busy
  isWorking_ = NO;
  
  // tell the delegate about the error
  [self.delegate stretchrContext:self connection:currentConnection_ didFailWithError:error];
  
  // clean up objects
  [currentResponseData_ release];
  [currentConnection_ release];
  
}

#pragma mark - Resource CRUD actions

- (NSURLConnection *)startConnectionToCreateResource:(StretchrResource*)resource {
  
  isWorking_ = YES;
  
  NSURLRequest *request = [self createUrlRequestToCreateResource:resource];
  return [self.connectionDelegate stretchrContext:self needsConnectionForRequest:request];
  
}

- (NSURLConnection *)startConnectionToReadResource:(StretchrResource*)resource {
  
  isWorking_ = YES;
  
  NSURLRequest *request = [self createUrlRequestToReadResource:resource];
  return [self.connectionDelegate stretchrContext:self needsConnectionForRequest:request];
  
}

- (NSURLConnection *)startConnectionToUpdateResource:(StretchrResource*)resource {
  
  isWorking_ = YES;
  
  NSURLRequest *request = [self createUrlRequestToUpdateResource:resource];
  return [self.connectionDelegate stretchrContext:self needsConnectionForRequest:request];
  
}

- (NSURLConnection *)startConnectionToDeleteResource:(StretchrResource*)resource {
  
  isWorking_ = YES;
  
  NSURLRequest *request = [self createUrlRequestToDeleteResource:resource];
  return [self.connectionDelegate stretchrContext:self needsConnectionForRequest:request];
  
}

@end

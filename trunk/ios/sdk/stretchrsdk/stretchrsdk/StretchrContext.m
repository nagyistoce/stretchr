//
//  StretchrContext.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrContext.h"
#import "StretchrResource.h"

@implementation StretchrContext
@synthesize delegate;
@synthesize accountName, publicKey, privateKey;
@synthesize domain, useSsl, dataType;

#pragma mark - init

- initWithAccountName:(NSString*)accName publicKey:(NSString*)pubKey privateKey:(NSString*)privKey {
  
  if ((self = [self init])) {
    
    // set properties
    self.accountName = accName;
    self.publicKey = pubKey;
    self.privateKey = privKey;
    
    // set the defaults
    self.domain = @"stretchr.com";
    self.dataType = @"json";
    self.delegate = self;
    
  }
  return self;
  
}

- (void)dealloc {
  
  self.accountName = nil;
  self.privateKey = nil;
  self.publicKey = nil;
  self.domain = nil;
  
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
  
  return [NSString stringWithFormat:@"%@://%@.%@",
          self.useSsl ? @"https" : @"http",
          self.accountName,
          self.domain];
  
}

- (NSString*)urlForResource:(StretchrResource*)resource {
  return [NSString stringWithFormat:@"%@%@/%@.%@", [self host], [resource fullRelativePathUrl], [resource resourceId], self.dataType];
}

- (NSString*)urlPathForResource:(StretchrResource*)resource {
  return [NSString stringWithFormat:@"%@%@.%@", [self host], [resource fullRelativePathUrl], self.dataType];
}

#pragma mark - StretchrContextRequestDelegate method

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
  [urlRequest setURL:[NSURL URLWithString:[context urlPathForResource:resource]]];
  [urlRequest setHTTPBody:[[resource postBodyStringIncludingId:YES] dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];

}

/**
 Configures an existing NSURLRequest object to read the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toReadResource:(StretchrResource*)resource {
 
  [urlRequest setHTTPMethod:[context httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodGET]];
  [urlRequest setURL:[NSURL URLWithString:[context urlForResource:resource]]];
  
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
  [urlRequest setURL:[NSURL URLWithString:[context urlForResource:resource]]];
  
}

@end

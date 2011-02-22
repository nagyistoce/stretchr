//
//  StretchrContext.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StretchrContextDelegate.h"
#import "StretchrContextRequestDelegate.h"
#import "StretchrContextConnectionDelegate.h"
#import "StretchrHttpMethod.h"
@class StretchrHttpResource;

/**
 Manages the context under which Stretchr is communicated with
 */
@interface StretchrContext : NSObject <StretchrContextRequestDelegate, StretchrContextConnectionDelegate> {
    
  // buffer for holding response data
  NSMutableData *currentResponseData_;
  NSURLConnection *currentConnection_;
  BOOL isWorking_;
  
}

#pragma mark - Properties

@property (assign) id<StretchrContextDelegate> delegate;
@property (assign) id<StretchrContextRequestDelegate> requestDelegate;
@property (assign) id<StretchrContextConnectionDelegate> connectionDelegate;

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *dataType;

@property (assign) BOOL useSsl;

#pragma mark - init

/**
 Initialises the context object with relevant settings and delegate object
 */
- initWithDelegate:(id<StretchrContextDelegate>)contextDelegate AccountName:(NSString*)accName publicKey:(NSString*)pubKey privateKey:(NSString*)privKey;

#pragma mark - URLs

/**
 Gets the host
 */
- (NSString*)host;

/**
 Gets the full URL for the specified resource
 */
- (NSString*)urlForResource:(StretchrResource*)resource;

/**
 Gets the full URL path for the specified resource
 */
- (NSString*)urlPathForResource:(StretchrResource*)resource;

#pragma mark - Http

- (NSString*)httpMethodStringFromStretchrHttpMethod:(StretchrHttpMethod)httpMethod;

#pragma mark - Resource CRUD actions

/**
 Creates a new NSURLConnection and starts creating the specified resource
 */
- (NSURLConnection *)startConnectionToCreateResource:(StretchrResource*)resource;

/**
 Creates a new NSURLConnection and starts reading the specified resource
 */
- (NSURLConnection *)startConnectionToReadResource:(StretchrResource*)resource;

/**
 Creates a new NSURLConnection and starts updating the specified resource
 */
- (NSURLConnection *)startConnectionToUpdateResource:(StretchrResource*)resource;

/**
 Creates a new NSURLConnection and starts deleting the specified resource
 */
- (NSURLConnection *)startConnectionToDeleteResource:(StretchrResource*)resource;

#pragma mark - Creating fully configured NSURLRequest objects

/**
 Creates a fully configured NSURLRequest ready to create the specified resource.
 */
- (NSURLRequest*)createUrlRequestToCreateResource:(StretchrResource*)resource;

/**
 Creates a fully configured NSURLRequest ready to read the specified resource.
 */
- (NSURLRequest*)createUrlRequestToReadResource:(StretchrResource*)resource;

/**
 Creates a fully configured NSURLRequest ready to update the specified resource.
 */
- (NSURLRequest*)createUrlRequestToUpdateResource:(StretchrResource*)resource;

/**
 Creates a fully configured NSURLRequest ready to delete the specified resource.
 */
- (NSURLRequest*)createUrlRequestToDeleteResource:(StretchrResource*)resource;

@end

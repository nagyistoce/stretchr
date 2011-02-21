//
//  StretchrContextRequestDelegate.h
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StretchrResource;
@class StretchrContext;

/**
 Protocol describing the interface for an object responsible for configuring
 NSURLRequest objects on behalf of the StretchrContext.
 */
@protocol StretchrContextRequestDelegate <NSObject>

@required

/**
 Creates and returns a new NSURLRequest for the given resource
 */
- (NSMutableURLRequest*)stretchrContext:(StretchrContext*)context urlRequestForResource:(StretchrResource*)resource;

/**
 Finalises any configuration for every kind of NSURLRequest
 */
- (void)stretchrContext:(StretchrContext*)context finishConfigurationForRequest:(NSMutableURLRequest*)urlRequest;

/**
 Configures an existing NSURLRequest object to create the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toCreateResource:(StretchrResource*)resource;

/**
 Configures an existing NSURLRequest object to read the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toReadResource:(StretchrResource*)resource;

/**
 Configures an existing NSURLRequest object to update the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toUpdateResource:(StretchrResource*)resource;

/**
 Configures an existing NSURLRequest object to delete the given resource
 */
- (void)stretchrContext:(StretchrContext*)context configureUrlRequest:(NSMutableURLRequest*)urlRequest toDeleteResource:(StretchrResource*)resource;

@end
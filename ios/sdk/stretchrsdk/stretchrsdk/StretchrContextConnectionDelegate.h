//
//  StretchrContextConnectionDelegate.h
//  stretchrsdk
//
//  Created by Mat Ryer on 22/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Protocol for an object responsible for creating and returning a new NSURLConnection
 for the specified StretchrContext and NSURLRequest.
 */
@protocol StretchrContextConnectionDelegate <NSObject>

/**
 Creates and returns a new NSURLConnection for the specified NSURLRequest.
 */
- (NSURLConnection*)stretchrContext:(StretchrContext*)context needsConnectionForRequest:(NSURLRequest*)request;

@end

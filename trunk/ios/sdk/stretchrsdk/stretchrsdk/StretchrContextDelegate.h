//
//  StretchrContextDelegate.h
//  stretchrsdk
//
//  Created by Mat Ryer on 22/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StretchrContext;
@class StretchrResponse;

@protocol StretchrContextDelegate <NSObject>

@optional

/**
 (Optional)
 Called when the context is resolving the host to use to make requests.
 If implemented by the delegate, the return of this method will be used
 instead of the generated host parameter.
 */
- (NSString*)stretchrContext:(StretchrContext*)context willUseHost:(NSString*)host;

@required

/**
 Called when a request connection failed with an error.
 */
- (void)stretchrContext:(StretchrContext*)context connection:(NSURLConnection*)connection didFailWithError:(NSError*)error;

/**
 Called when a request connection has finished loading.
 */
- (void)stretchrContext:(StretchrContext*)context connectionDidFinishLoading:(NSURLConnection*)connection withResponse:(StretchrResponse*)response;

@end

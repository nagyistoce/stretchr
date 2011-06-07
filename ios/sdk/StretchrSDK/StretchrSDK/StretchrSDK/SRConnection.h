//
//  SRConnection.h
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRRequest;
@class SRResponse;

@interface SRConnection : NSObject {
  NSURLRequest *request_;
  NSURLConnection *underlyingConnection_;
}

@property (nonatomic, assign) BOOL isBusy;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) SRResponse *response;

@property (nonatomic, readonly) NSURLRequest* request;
@property (nonatomic, retain) SRRequest *originalRequest;
@property (nonatomic, readonly) NSURLConnection *underlyingConnection;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

- (id)initWithRequest:(NSURLRequest*)request originalRequest:(SRRequest*)originalRequest;
- (id)initWithRequest:(NSURLRequest*)request originalRequest:(SRRequest*)originalRequest target:(id)target selector:(SEL)selector;

- (void)start;
- (void)cancel;

@end

//
//  SRConnection.h
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SRConnection : NSObject {
  NSURLRequest *request_;
  NSURLConnection *underlyingConnection_;
}

@property (nonatomic, assign) BOOL isBusy;
@property (nonatomic, readonly) NSURLRequest* request;
@property (nonatomic, readonly) NSURLConnection *underlyingConnection;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

- (id)initWithRequest:(NSURLRequest*)request;
- (id)initWithRequest:(NSURLRequest*)request target:(id)target selector:(SEL)selector;

- (void)start;
- (void)cancel;

@end

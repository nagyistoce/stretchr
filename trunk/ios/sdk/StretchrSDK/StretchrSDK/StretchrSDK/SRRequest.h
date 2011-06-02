//
//  SRRequest.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRequestMethod.h"
#import "SRParameterCollection.h"
@class SRCredentials;

@interface SRRequest : NSObject {
  SRParameterCollection *parameters_;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) SRParameterCollection *parameters;
@property (assign) SRRequestMethod method;
@property (nonatomic, retain) SRCredentials *credentials;

#pragma mark - init

- (id)initWithUrl:(NSURL*)url method:(SRRequestMethod)method credentials:(SRCredentials*)credentials;

#pragma mark - NSURLRequest integration

- (NSURLRequest*)makeSignedUrlRequest;

#pragma mark - Parameters

- (BOOL)hasParameters;

@end

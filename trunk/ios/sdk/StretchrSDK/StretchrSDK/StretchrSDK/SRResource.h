//
//  SRResource.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRFoundation.h"
@class SRConnection;

@interface SRResource : NSObject {
    
}

#pragma mark - Properties

@property (nonatomic, copy) NSString *path;
@property (nonatomic, retain) SRParameterCollection *parameters;
@property (nonatomic, copy) NSString *resourceId;

#pragma mark - init

- (id)initWithPath:(NSString*)path;
- (id)initWithPath:(NSString*)path resourceId:(NSString*)resourceId;

#pragma mark - Parameters

- (void)addParameterValue:(NSString*)value forKey:(NSString*)key;
- (void)setParameterValue:(NSString*)value forKey:(NSString*)key;
- (NSString*)firstValueForKey:(NSString*)key;

#pragma mark - Resource ID

- (BOOL)hasResourceId;

#pragma mark - Actions

- (SRConnection*)createConnectionForRequest:(NSURLRequest*)request withOriginalRequest:(SRRequest*)originalRequest target:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately;

- (SRConnection*)createThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately;
- (SRConnection*)readThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately;
- (SRConnection*)updateThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately;
- (SRConnection*)deleteThenCallTarget:(id)target selector:(SEL)selector startImmediately:(BOOL)startImmediately;

@end

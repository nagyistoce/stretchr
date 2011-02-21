//
//  StretchrContext.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StretchrHttpResource;

/**
 Manages the context under which Stretchr is communicated with
 */
@interface StretchrContext : NSObject {
    
}

#pragma mark - Properties

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *privateKey;
@property (nonatomic, copy) NSString *domain;

@property (assign) BOOL useSsl;

/**
 Initialises the context object with relevant settings
 */
- (id)initWithAccountName:(NSString*)account publicKey:(NSString*)pubKey privateKey:(NSString*)privKey;

#pragma mark - URLs

/**
 Gets the host
 */
- (NSString*)host;

/**
 Gets the full URL for the specified resource
 */
- (NSString*)urlForResource:(StretchrHttpResource*)resource;

@end

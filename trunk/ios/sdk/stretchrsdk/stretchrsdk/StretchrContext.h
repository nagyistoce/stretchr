//
//  StretchrContext.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class StretchrResource;

@interface StretchrContext : NSObject {
    
}

#pragma mark - Properties

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *publicKey;
@property (nonatomic, copy) NSString *privateKey;

@property (assign) BOOL useSsl;

/**
 Initialises the context object with relevant settings
 */
- (id)initWithAccountName:(NSString*)account publicKey:(NSString*)pubKey privateKey:(NSString*)privKey;

#pragma mark - URLs

- (NSString*)serverDomain;
- (NSString*)urlForResource:(StretchrResource*)resource;

@end

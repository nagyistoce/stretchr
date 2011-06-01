//
//  SRContext.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class SRResource;
@class SRCredentials;

@interface SRContext : NSObject {
  
}

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, retain) SRCredentials *credentials;

SingletonInterface(SRContext);

- (void)setAccountName:(NSString*)accountName key:(NSString*)key secret:(NSString*)secret;

- (NSString*)rootURL;

- (NSURL*)URLForResource:(SRResource*)resource;

@end

//
//  SRRequestSigner.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRRequest;

@interface SRRequestSigner : NSObject {
    
}

- (void)configureSignParameterOnRequest:(SRRequest*)request;

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request;

- (NSString*)stringLowercaseUrl:(NSURL*)url;

- (NSString*)orderedParameterStringWithSecretForRequest:(SRRequest*)request;

- (NSString*)uppercaseMethodForRequest:(SRRequest*)request __attribute__ ((deprecated));

- (NSString*)unencodedSignatureStringForRequest:(SRRequest*)request;

- (NSString *)HMAC_SHA1SignatureForText:(NSString *)text;

@end

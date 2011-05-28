//
//  SRRequestSigner.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRRequest;

#define GET_HTTP_METHOD @"GET"
#define POST_HTTP_METHOD @"POST"
#define PUT_HTTP_METHOD @"PUT"
#define DELETE_HTTP_METHOD @"DELETE"

@interface SRRequestSigner : NSObject {
    
}

- (void)configureSignParameterOnRequest:(SRRequest*)request;

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request;

- (NSString*)stringLowercaseUrl:(NSURL*)url;

- (NSString*)orderedParameterStringWithSecretForRequest:(SRRequest*)request;

- (NSString*)uppercaseProtocolForRequest:(SRRequest*)request;

- (NSString*)unencodedSignatureStringForRequest:(SRRequest*)request;

- (NSString *)HMAC_SHA1SignatureForText:(NSString *)text usingSecret:(NSString *)secret;

@end

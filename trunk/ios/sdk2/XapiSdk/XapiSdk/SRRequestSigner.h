//
//  SRRequestSigner.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRRequest;

@interface SRRequestSigner : NSObject {
    
}

- (NSString*)generatorSignatureFromRequest:(SRRequest*)request;

@end

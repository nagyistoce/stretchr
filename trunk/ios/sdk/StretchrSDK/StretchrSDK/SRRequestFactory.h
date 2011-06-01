//
//  SRRequestFactory.h
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRequest.h"
#import "SRResource.h"

@interface SRRequestFactory : NSObject {
    
}

+ (SRRequest*)requestToCreateResource:(SRResource*)resource;

@end

//
//  SRRequestFactory.h
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRFoundation.h"

@interface SRRequestFactory : NSObject {
    
}

+ (SRRequest*)requestToCreateResource:(SRResource*)resource;
+ (SRRequest*)requestToReadResource:(SRResource*)resource;
+ (SRRequest*)requestToUpdateResource:(SRResource*)resource;
+ (SRRequest*)requestToDeleteResource:(SRResource*)resource;

+ (SRRequest*)requestForResource:(SRResource*)resource withMethod:(SRRequestMethod)method;

@end

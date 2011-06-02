//
//  SRHttpHelper.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRRequestMethod.h"

#pragma mark Method strings

@interface SRHttpHelper : NSObject {
    
}

+ (NSString*)methodStringForMethod:(SRRequestMethod)method;

@end

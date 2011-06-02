//
//  TestTargetObject.h
//  StretchrSDK
//
//  Created by Mat Ryer on 2/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRResponse;

@interface TestTargetObject : NSObject {
    
}

@property (nonatomic, retain) SRResponse *lastResponse;

- (void)processResponse:(SRResponse*)response;

@end

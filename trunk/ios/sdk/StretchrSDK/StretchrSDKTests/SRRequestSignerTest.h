//
//  SRRequestSignerTest.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
@class SRRequest;
@class SRRequestSigner;

@interface SRRequestSignerTest : SenTestCase {
    
}

@property (nonatomic, retain) SRRequestSigner *signer;
@property (nonatomic, retain) SRRequest *request;

@end

//
//  SRRequestMethodTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRRequestMethodTest.h"
#import "SRRequestMethod.h"

@implementation SRRequestMethodTest

- (void)testSRRequestMethodHasPostBody {
  
  STAssertTrue(SRRequestMethodHasPostBody(SRRequestMethodPOST), @"POST should have request body");
  STAssertTrue(SRRequestMethodHasPostBody(SRRequestMethodPUT), @"PUT should have request body");
  
  STAssertFalse(SRRequestMethodHasPostBody(SRRequestMethodGET), @"GET should not have request body");
  STAssertFalse(SRRequestMethodHasPostBody(SRRequestMethodDELETE), @"DELETE should not have request body");
  
}

@end

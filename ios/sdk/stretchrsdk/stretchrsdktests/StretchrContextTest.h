//
//  StretchrContextTest.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>
#import "Stretchr.h"

#define TEST_HOST_VALUE @"http://www.google.com"

@interface StretchrContextTest : SenTestCase <StretchrContextDelegate> {
  StretchrContext *testContext;
}

- (StretchrResource*)createTestResource;

@end
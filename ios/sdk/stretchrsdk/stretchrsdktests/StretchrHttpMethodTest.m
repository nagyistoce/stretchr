//
//  StretchrHttpMethodTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrHttpMethodTest.h"


@implementation StretchrHttpMethodTest

- (void)testMethods {
  
  STAssertEquals(StretchrHttpMethodGET, 0, @"GET method missing");
  STAssertEquals(StretchrHttpMethodPOST, 1, @"POST method missing");
  STAssertEquals(StretchrHttpMethodPUT, 2, @"PUT method missing");
  STAssertEquals(StretchrHttpMethodDELETE, 3, @"DELETE method missing");
  
}

@end

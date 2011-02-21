//
//  StretchrRequestTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrRequestTest.h"


@implementation StretchrRequestTest

- (void)testProperties {
  
  StretchrRequest *request = [[StretchrRequest alloc] init];
  
  [request setHttpMethod:StretchrHttpMethodPOST];
  STAssertEquals(request.httpMethod, StretchrHttpMethodPOST, @"httpMethod incorrect");
  
}

@end

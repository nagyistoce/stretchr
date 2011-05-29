//
//  SRHttpHelperTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRHttpHelperTest.h"
#import "SRHttpHelper.h"
#import "SRRequestMethod.h"

@implementation SRHttpHelperTest

- (void)testMethodStringForMethod {
  
  STAssertTrue([@"GET" isEqualToString:[SRHttpHelper methodStringForMethod:SRRequestMethodGET]], @"Should be GET");
  STAssertTrue([@"POST" isEqualToString:[SRHttpHelper methodStringForMethod:SRRequestMethodPOST]], @"Should be POST");
  STAssertTrue([@"PUT" isEqualToString:[SRHttpHelper methodStringForMethod:SRRequestMethodPUT]], @"Should be PUT");
  STAssertTrue([@"DELETE" isEqualToString:[SRHttpHelper methodStringForMethod:SRRequestMethodDELETE]], @"Should be DELETE");
  
}

@end

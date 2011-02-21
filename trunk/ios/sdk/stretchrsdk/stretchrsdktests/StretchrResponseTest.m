//
//  StretchrResponseTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResponseTest.h"
#import "TestHelpers.h"

@implementation StretchrResponseTest

- (void)setUp {
  
  response = [[StretchrResponse alloc] init];
  
}
- (void)tearDown {
  [response release];
  response = nil;
}

- (void)testProperties {
  
  response.worked = YES;
  response.status = 200;
  response.context = @"one-two-three";
  response.response = @"string response";
  
  NSArray *errors = [[NSArray alloc] initWithObjects:@"bloody error", nil];
  response.errors = errors;

  // check all properties
  STAssertEquals(response.worked, YES, @".worked incorrect");
  STAssertEquals(response.status, 200, @".status incorrect");
  STAssertEquals(response.context, @"one-two-three", @".context incorrect");
  STAssertStringsEqual(response.response, @"string response", @".response incorrect");
  STAssertEquals(response.errors, errors, @".errors incorrect");
  
  [errors release];

}

@end
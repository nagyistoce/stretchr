//
//  StretchrResourceCollectionTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrResourceCollectionTest.h"
#import "TestHelpers.h"

@implementation StretchrResourceCollectionTest

- (void)testInit {
  
  StretchrResourceCollection *resources = [[StretchrResourceCollection alloc] initWithPath:@"/people"];
  
  [resources release];
  
}

@end

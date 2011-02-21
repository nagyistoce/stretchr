//
//  TestHelpers.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//


// Asserts two strings are the same using isEqualToString
#define STAssertStringsEqual(s1, s2, m) STAssertTrue([s1 isEqualToString:s2], m)
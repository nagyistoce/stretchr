//
//  TestHelper.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#define STAssertEqualStrings(actual, expected, message) STAssertTrue([expected isEqualToString:actual], @"%@Strings do not match, expected: \"%@\", actual: \"%@\".", message ? @"" : [NSString stringWithFormat:@"%@ - ", message], expected, actual)

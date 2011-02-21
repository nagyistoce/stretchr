//
//  StretchrResourceCollection.h
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StretchrHttpResource.h"

@interface StretchrResourceCollection : StretchrHttpResource {
  
}

#pragma mark - Properties

@property (nonatomic, assign) NSUInteger totalLength;
@property (nonatomic, assign) NSUInteger startIndex;
@property (nonatomic, assign) NSUInteger endIndex;
@property (nonatomic, retain) NSArray *resources;

@end
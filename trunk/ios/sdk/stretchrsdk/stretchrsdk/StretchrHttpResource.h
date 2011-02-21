//
//  StretchrHttpResource.h
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StretchrHttpResource : NSObject {
    
}

/**
 The path of this resource.
 */
@property (nonatomic, copy) NSString *path;

#pragma mark - init

/**
 Initialises the StretchrHttpResource with the given path.
 */
- (id)initWithPath:(NSString*)httpResourcePath;

#pragma mark - URLs

/**
 Gets the full path (relative to the domain) for this resource.
 */
- (NSString*)fullRelativePath;

@end

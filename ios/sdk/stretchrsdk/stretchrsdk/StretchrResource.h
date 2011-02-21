//
//  StretchrResource.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StretchrHttpResource.h"

/**
 Represents a single Stretchr resource
 */
@interface StretchrResource : StretchrHttpResource {
    
}

@property (nonatomic, retain) NSMutableDictionary *properties;

#pragma mark - init

/**
 Creates a new resource with the given path
 */
- (id)initWithPath:(NSString*)resourcePath;

/**
 Creates a new resource with the given path and ID
 */
- (id)initWithPath:(NSString*)resourcePath andId:(NSString*)resId;

/**
 Creates a new resource with the given path and properties
 */
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)properties;

/**
 Creates a new resource with the given path, properties and ID
 */
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)properties andId:(NSString*)resId;

#pragma mark - State

/**
 Gets the ID for this resource
 */
- (NSString*)resourceId; 

/**
 Sets the ID for this resource
 */
- (void)setResourceId:(NSString*)resId;

/**
 Checks whether the resource exists or not (locally)
 I.e. does it have an ID value
 */
- (BOOL)exists;

#pragma mark - Data

/**
 Gets the HTTP post body style string representing the properties
 */
- (NSString*)postBodyStringIncludingId:(BOOL)includeId;

@end

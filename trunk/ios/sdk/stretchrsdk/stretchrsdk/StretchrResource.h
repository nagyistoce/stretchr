//
//  StretchrResource.h
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StretchrResource : NSObject {
    
}

@property (nonatomic, copy) NSString *resourceId;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, retain) NSMutableDictionary *properties;

#pragma mark - init

- (id)initWithPath:(NSString*)resourcePath;
- (id)initWithPath:(NSString*)resourcePath andId:(NSString*)resId;
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)properties;
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)properties andId:(NSString*)resId;

#pragma mark - State

- (BOOL)exists;

@end

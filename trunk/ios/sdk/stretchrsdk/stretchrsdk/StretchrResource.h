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

@property (nonatomic, copy) NSString *path;
@property (nonatomic, retain) NSMutableDictionary *properties;

- (id)initWithPath:(NSString*)resourcePath;
- (id)initWithPath:(NSString*)resourcePath andProperties:(NSMutableDictionary*)properties;

@end

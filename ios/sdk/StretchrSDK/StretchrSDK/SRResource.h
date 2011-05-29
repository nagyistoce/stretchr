//
//  SRResource.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SRResource : NSObject {
    
}

#pragma mark - Properties

@property (nonatomic, copy) NSString *path;

#pragma mark - init

- (id)initWithPath:(NSString*)path;

@end

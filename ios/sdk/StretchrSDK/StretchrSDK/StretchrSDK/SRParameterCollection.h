//
//  SRParameterCollection.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRParameter.h"

@interface SRParameterCollection : NSObject {
    
}

@property (nonatomic, retain) NSMutableArray *parameters;

#pragma mark - Content management

- (SRParameter*)firstParameterWithKey:(NSString*)key;
- (void)addValue:(NSString*)value forKey:(NSString*)key;
- (void)setSingleValue:(NSString*)value forKey:(NSString*)key;

- (void)mergeWithParameters:(SRParameterCollection*)parameters;

#pragma mark - Parameter string

- (NSString*)orderedParameterString;

#pragma mark - Normal NSArray methods

- (SRParameter*)objectAtIndex:(NSUInteger)index;
- (NSUInteger)count;

@end

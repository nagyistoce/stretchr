//
//  SRParameterCollection.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRParameter.h"

@interface SRParameterCollection : NSObject {
    
}

@property (nonatomic, retain) NSMutableArray *parameters;

- (void)addValue:(NSString*)value forKey:(NSString*)key;

#pragma mark - Normal NSArray methods

- (SRParameter*)objectAtIndex:(NSUInteger)index;
- (NSUInteger)count;

@end

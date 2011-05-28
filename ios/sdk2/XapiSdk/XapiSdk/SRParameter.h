//
//  SRParameter.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SRParameter : NSObject {
    
}

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

- (id)initWithKey:(NSString*)key andValue:(NSString*)value;

- (NSComparisonResult)compare:(id)object;

@end

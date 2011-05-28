//
//  SRParameter.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KEY_PARAMETER_KEY @"~key"
#define SECRET_PARAMETER_KEY @"~secret"
#define SIGN_PARAMETER_KEY @"~sign"

@interface SRParameter : NSObject {
    
}

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

- (id)initWithKey:(NSString*)key andValue:(NSString*)value;

- (NSString *)URLEncodedParameterString;

- (NSComparisonResult)compare:(id)object;

@end

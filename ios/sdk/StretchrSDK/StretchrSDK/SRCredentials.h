//
//  SRCredentials.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SRCredentials : NSObject {
    
}

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *secret;

- (id)initWithKey:(NSString*)key secret:(NSString*)secret;

@end

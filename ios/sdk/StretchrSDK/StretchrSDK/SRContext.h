//
//  SRContext.h
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SRContext : NSObject {
  
}

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *secret;

SingletonInterface(SRContext);

@end

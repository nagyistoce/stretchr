//
//  SRContext.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRContext.h"


@implementation SRContext
@synthesize accountName, key, secret;

SingletonImplementation(SRContext);

@end

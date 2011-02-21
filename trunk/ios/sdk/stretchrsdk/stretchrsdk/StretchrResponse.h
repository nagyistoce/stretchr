//
//  StretchrResponse.h
//  stretchrsdk
//
//  Created by Mat Ryer on 21/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StretchrResponse : NSObject {
    
}

#pragma mark - Properties

@property (nonatomic, assign) BOOL worked;
@property (nonatomic, copy) NSString *context;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, retain) NSArray *errors;
@property (nonatomic, retain) id response;

@end

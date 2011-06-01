//
//  SRResponse.h
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SRResponse : NSObject {
    
}

@property (nonatomic, retain) NSURLResponse *urlResponse;
@property (nonatomic, retain) NSError *error;

- (id)initWithResponse:(NSURLResponse*)response;
- (id)initWithError:(NSError*)theError;

- (BOOL)success;

@end

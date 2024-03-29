//
//  SRResponse.h
//  StretchrSDK
//
//  Created by Mat Ryer on 1/Jun/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SRConnection;

@interface SRResponse : NSObject {
    
}

@property (nonatomic, retain) SRConnection *connection;
@property (nonatomic, retain) NSHTTPURLResponse *urlResponse;
@property (nonatomic, retain) NSError *error;
@property (nonatomic, retain) NSData *data;

- (id)initWithResponse:(NSHTTPURLResponse*)response;
- (id)initWithError:(NSError*)theError;

- (BOOL)success;

@end

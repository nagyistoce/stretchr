//
//  StretchrContext.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrContext.h"


@implementation StretchrContext
@synthesize accountName, publicKey, privateKey;

- initWithAccountName:(NSString*)accName publicKey:(NSString*)pubKey privateKey:(NSString*)privKey {
  
  if ((self = [self init])) {
    
    self.accountName = accName;
    self.publicKey = pubKey;
    self.privateKey = privKey;
    
  }
  return self;
  
}

- (void)dealloc {
  
  self.accountName = nil;
  self.privateKey = nil;
  self.publicKey = nil;
  
  [super dealloc];
  
}

@end

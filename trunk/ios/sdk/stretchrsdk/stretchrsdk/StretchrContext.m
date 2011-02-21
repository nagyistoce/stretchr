//
//  StretchrContext.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Stretchr. All rights reserved.
//

#import "StretchrContext.h"
#import "StretchrHttpResource.h"

@implementation StretchrContext
@synthesize accountName, publicKey, privateKey;
@synthesize domain;
@synthesize useSsl;
@synthesize dataType;

#pragma mark - init

- initWithAccountName:(NSString*)accName publicKey:(NSString*)pubKey privateKey:(NSString*)privKey {
  
  if ((self = [self init])) {
    
    self.accountName = accName;
    self.publicKey = pubKey;
    self.privateKey = privKey;
    
    // set the defaults
    self.domain = @"stretchr.com";
    self.dataType = @"json";
    
  }
  return self;
  
}

- (void)dealloc {
  
  self.accountName = nil;
  self.privateKey = nil;
  self.publicKey = nil;
  self.domain = nil;
  
  [super dealloc];
  
}

#pragma mark - URLs

- (NSString*)host {
  
  return [NSString stringWithFormat:@"%@://%@.%@",
          self.useSsl ? @"https" : @"http",
          self.accountName,
          self.domain];
  
}

- (NSString*)urlForResource:(StretchrHttpResource*)resource {
  
  return [NSString stringWithFormat:@"%@%@.%@", [self host], [resource fullRelativePath], self.dataType];
  
}

@end

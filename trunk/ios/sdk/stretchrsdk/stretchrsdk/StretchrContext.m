//
//  StretchrContext.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "StretchrContext.h"
#import "StretchrResource.h"
#import "StretchrConstants.h"

@implementation StretchrContext
@synthesize accountName, publicKey, privateKey;
@synthesize useSsl;

#pragma mark - init

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

#pragma mark - URLs

- (NSString*)serverDomain {
  
  return [NSString stringWithFormat:@"%@://%@.%@",
          self.useSsl ? @"https" : @"http",
          self.accountName,
          STRETCHR_DOMAIN];
  
}

- (NSString*)urlForResource:(StretchrResource*)resource {
  
  NSString *idBit = @"";
  
  if ([resource exists]) {
    idBit = [NSString stringWithFormat:@"/%@", resource.resourceId];
  }
  
  return [NSString stringWithFormat:@"%@%@%@", [self serverDomain], resource.path, idBit];
  
}

@end

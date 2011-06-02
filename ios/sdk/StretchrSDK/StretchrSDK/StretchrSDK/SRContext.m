//
//  SRContext.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//
#import "SRContext.h"
#import "SRResource.h"

@implementation SRContext
@synthesize accountName;
@synthesize credentials;

SingletonImplementation(SRContext);

- (void)setAccountName:(NSString*)theAccountName key:(NSString*)theKey secret:(NSString*)theSecret {
  
  [self setAccountName:theAccountName];

  SRCredentials *creds = [[SRCredentials alloc] initWithKey:theKey secret:theSecret];
  self.credentials = creds;
  [creds release];
  
}

- (void)dealloc {
  
  self.accountName = nil;
  self.credentials = nil;
  
  [super dealloc];
}

- (NSString*)rootURL {
  return [NSString stringWithFormat:XAPI_DOMAIN_FORMAT, self.accountName];
}

- (NSURL*)URLForResource:(SRResource*)resource {
  
  NSString *url = nil;
  NSString *path = [NSString stringWithFormat:@"%@%@", [self rootURL], resource.path];
  
  if ([resource hasResourceId]) {
    url = [NSString stringWithFormat:@"%@%@%@", path, URL_PATH_SEPERATOR, [resource resourceId]];
  } else {
    url = path;
  }
  
  return [NSURL URLWithString:url];
  
}

@end

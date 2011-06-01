//
//  SRContext.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
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
  return [NSString stringWithFormat:@"http://%@.xapi.co", self.accountName];
}

- (NSURL*)URLForResource:(SRResource*)resource {
  return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self rootURL], resource.path]];
}

@end

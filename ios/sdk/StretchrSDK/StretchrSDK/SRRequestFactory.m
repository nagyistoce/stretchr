//
//  SRRequestFactory.m
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRRequestFactory.h"
#import "SRContext.h"

@implementation SRRequestFactory

+ (SRRequest*)requestToCreateResource:(SRResource*)resource {
  
  SRRequest *request = [[SRRequest alloc] initWithUrl:[[SRContext sharedInstance] URLForResource:resource] 
                                               method:SRRequestMethodGET 
                                          credentials:[[SRContext sharedInstance] credentials]];
  
  // set the parameters
  [request.parameters setParameters:resource.parameters.parameters];
  
  return request;
  
}

@end

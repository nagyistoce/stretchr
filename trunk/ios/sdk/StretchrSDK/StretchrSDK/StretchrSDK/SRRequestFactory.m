//
//  SRRequestFactory.m
//  StretchrSDK
//
//  Created by Mat Ryer on 31/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRRequestFactory.h"

@implementation SRRequestFactory



+ (SRRequest*)requestToCreateResource:(SRResource*)resource {
return [self requestForResource:resource withMethod:SRRequestMethodPOST];
}

+ (SRRequest*)requestToReadResource:(SRResource*)resource {
return [self requestForResource:resource withMethod:SRRequestMethodGET];
}

+ (SRRequest*)requestToUpdateResource:(SRResource*)resource {
  return [self requestForResource:resource withMethod:SRRequestMethodPUT];
}

+ (SRRequest*)requestToDeleteResource:(SRResource*)resource {
  return [self requestForResource:resource withMethod:SRRequestMethodDELETE];
}




+ (SRRequest*)requestForResource:(SRResource*)resource withMethod:(SRRequestMethod)method {
  
  SRRequest *request = [[[SRRequest alloc] initWithUrl:[[SRContext sharedInstance] URLForResource:resource] 
                                                method:method
                                           credentials:[[SRContext sharedInstance] credentials]] autorelease];
  
  // set the parameters
  [request.parameters mergeWithParameters:resource.parameters];
  
  return request;
  
}

@end

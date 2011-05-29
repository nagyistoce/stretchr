//
//  SRHttpHelper.m
//  StretchrSDK
//
//  Created by Mat Ryer on 29/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#import "SRHttpHelper.h"


@implementation SRHttpHelper

+ (NSString*)methodStringForMethod:(SRRequestMethod)method {
  switch (method) {
    case SRRequestMethodGET:
      return GET_HTTP_METHOD;
      break;
    case SRRequestMethodPOST:
      return POST_HTTP_METHOD;
      break;
    case SRRequestMethodPUT:
      return PUT_HTTP_METHOD;
      break;
    case SRRequestMethodDELETE:
      return DELETE_HTTP_METHOD;
      break;
  }
  
  return nil;
}

@end

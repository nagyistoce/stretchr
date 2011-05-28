//
//  SRRequestMethod.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

/**
 Represents HTTP Methods
 */
typedef enum {
  SRRequestMethodGET,
  SRRequestMethodPUT,
  SRRequestMethodPOST,
  SRRequestMethodDELETE
} SRRequestMethod;

/**
 Gets whether a request with the given HTTP Method should have a post body or not
 */
#define SRRequestMethodHasPostBody(method) (method == SRRequestMethodPOST || method == SRRequestMethodPUT)

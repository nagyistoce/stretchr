//
//  TestValues.h
//  XapiSdk
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Borealis Web Ltd. All rights reserved.
//

#define EXPECTED_SIGNATURE @"ad58377ce4a0bab31818c2a4107cff36f2cb0ce2"
#define EXPECTED_PARAMETER_STRING @"FName=Edd&email=edd%40eddgrant.com&email=edd%40stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~z=Mat%26Grant%2FRyer%26Edd"
#define EXPECTED_PARAMETER_STRING_WITH_SECRET @"FName%3DEdd%26email%3Dedd%2540eddgrant.com%26email%3Dedd%2540stretchr.com%26lName%3DGrant%26~c%3Dthis-is-my-context-value%26~key%3Dabdh239d78c30f93jf88r0%26~secret%3DthisIsMySecretValue"
#define EXPECTED_UNENCODED_SIGNATURE_STRING @"POST&http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople&FName%3DEdd%26email%3Dedd%2540eddgrant.com%26email%3Dedd%2540stretchr.com%26lName%3DGrant%26~c%3Dthis-is-my-context-value%26~key%3Dabdh239d78c30f93jf88r0%26~secret%3DthisIsMySecretValue"

#define TEST_URL @"http://EDD-test-domain.xapi.co/Groups/1/People"
#define TEST_LOWERCASE_URL @"http://edd-test-domain.xapi.co/groups/1/people"

#define TEST_METHOD SRRequestMethodPOST
#define TEST_KEY @"abdh239d78c30f93jf88r0"
#define TEST_SECRET @"thisIsMySecretValue"
#define TEST_CONTEXT @"this-is-my-context-value"

#define PARAM1_KEY @"FName"
#define PARAM1_VALUE @"Edd"

#define PARAM2_KEY @"email"
#define PARAM2_VALUE @"edd@eddgrant.com"

#define PARAM3_KEY @"email"
#define PARAM3_VALUE @"edd@stretchr.com"

#define PARAM4_KEY @"lName"
#define PARAM4_VALUE @"Grant"

#define PARAM5_KEY @"~c"
#define PARAM5_VALUE TEST_CONTEXT

#define KEYPARAM_KEY @"~key"
#define KEYPARAM_VALUE TEST_KEY

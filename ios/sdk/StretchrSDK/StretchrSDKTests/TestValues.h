//
//  TestValues.h
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#pragma mark - Resources

#define TEST_PATH @"/people"

#pragma mark - Foundation

#define EXPECTED_SIGNATURE @"35b6d34742395160d3784b6b1a4e92e493a24453"
#define EXPECTED_PARAMETER_STRING @"FName=Edd&email=edd@eddgrant.com&email=edd@stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~z=Mat&Grant/Ryer&Edd"
#define EXPECTED_PARAMETER_STRING_WITH_SECRET @"FName%3DEdd%26email%3Dedd%40eddgrant.com%26email%3Dedd%40stretchr.com%26lName%3DGrant%26%7Ec%3Dthis-is-my-context-value%26%7Ekey%3Dabdh239d78c30f93jf88r0%26%7Esecret%3DthisIsMySecretValue"
#define EXPECTED_UNENCODED_SIGNATURE_STRING @"POST&http%3A%2F%2Fedd-test-domain.xapi.co%2Fgroups%2F1%2Fpeople&FName%3DEdd%26email%3Dedd%40eddgrant.com%26email%3Dedd%40stretchr.com%26lName%3DGrant%26%7Ec%3Dthis-is-my-context-value%26%7Ekey%3Dabdh239d78c30f93jf88r0%26%7Esecret%3DthisIsMySecretValue"

#define EXPECTED_FINAL_POST_DATA @"FName=Edd&email=edd@eddgrant.com&email=edd@stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~sign=35b6d34742395160d3784b6b1a4e92e493a24453"
#define EXPECTED_FINAL_PUT_DATA @"FName=Edd&email=edd@eddgrant.com&email=edd@stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~sign=18a3bbcf63989eb643dc7cabb6187ef0721d9d37"

#define TEST_URL @"http://EDD-test-domain.xapi.co/Groups/1/People"
#define TEST_LOWERCASE_URL @"http://edd-test-domain.xapi.co/groups/1/people"

#define EXPECTED_FULL_URL_FOR_GET @"http://EDD-test-domain.xapi.co/Groups/1/People?FName=Edd&email=edd@eddgrant.com&email=edd@stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~sign=fcecf5339fce6a671eb856967e8e3956a861d41a"

#define EXPECTED_FULL_URL_FOR_DELETE @"http://EDD-test-domain.xapi.co/Groups/1/People?FName=Edd&email=edd@eddgrant.com&email=edd@stretchr.com&lName=Grant&~c=this-is-my-context-value&~key=abdh239d78c30f93jf88r0&~sign=9d38c01a706b0e7a47437de1668870e16c3918b1"

#define TEST_ACCOUNT @"EDD-test-domain"
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

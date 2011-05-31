//
//  SRRequestTest.m
//  StretchrSDK
//
//  Created by Mat Ryer on 28/May/2011.
//  Copyright 2011 Stretchr.com. All rights reserved.
//

#import "SRRequestTest.h"
#import "SRRequest.h"
#import "SRCredentials.h"
#import "SRParameterCollection.h"
#import "TestValues.h"

@implementation SRRequestTest

- (void)testInit {
  
  SRRequest *request = [[SRRequest alloc] init];
  STAssertNotNil(request, @"Request shouldn't be nil");
  [request release];
  
}

- (void)testInitWithUrlMethod {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPUT credentials:creds];
  
  STAssertEqualObjects(url, request.url, @"url should have been set");
  STAssertEquals(SRRequestMethodPUT, request.method, @"method should have been set");
  STAssertEqualObjects(creds, request.credentials, @"credentials should have been set");
  
  [creds release];
  [request release];
  
}

- (void)testRequestAutomaticallyAddsKeyParameter {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPUT credentials:creds];
  
  STAssertEquals((NSUInteger)1, [request.parameters count], @"Request should automatically add the key parameter");
  
  /*
  NSLog(@"--------------------------------------------------------");
  NSLog(@"key: %@", [request.parameters objectAtIndex:0].key);
  NSLog(@"value: %@", [request.parameters objectAtIndex:0].value);
  NSLog(@"--------------------------------------------------------");
  */
  
  STAssertTrue([[request.parameters objectAtIndex:0].key isEqualToString:KEY_PARAMETER_KEY], @"key wasn't correctly set");
  STAssertTrue([[request.parameters objectAtIndex:0].value isEqualToString:TEST_KEY], @"key value wasn't correctly set");
  
  [creds release];
  [request release];
  
}

- (void)testParameters {
  
  SRRequest *request = [[SRRequest alloc] init];
  
  STAssertFalse([request hasParameters], @"hasParameters should be false to start with");
  
  // an empty NSMutableDictionay should be returned
  STAssertNotNil([request parameters], @"[request parameters] shouldn't be nil");
  
  STAssertTrue([request hasParameters], @"hasParameters should be true after calling it.");
  
  [request release];
  
}

- (void)testMakeSignedUrlRequestForPOST {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPOST credentials:creds];
  
  // add the parameters
  [request.parameters addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [request.parameters addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [request.parameters addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [request.parameters addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [request.parameters addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  
  NSURLRequest *urlRequest = [request makeSignedUrlRequest];
  
  // check the URL
  NSString *actualUrl = [urlRequest.URL absoluteString];
  NSString *expectedUrl = [url absoluteString];
  STAssertTrue([actualUrl isEqualToString:expectedUrl], @"Incorrect URL.  Expected '%@' but was '%@'.", expectedUrl, actualUrl);
  
  // check the HTTP body
  NSData *postData = [urlRequest HTTPBody];
  NSString *postDataString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
  
  STAssertTrue([postDataString isEqualToString:EXPECTED_FINAL_POST_DATA], @"Post Data incorrect, expected \"%@\" but was \"%@\".", EXPECTED_FINAL_POST_DATA, postDataString);
  
  /*
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Expected Post data:");
   NSLog(@"%@", EXPECTED_FINAL_POST_DATA);
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Actual Post data:");
   NSLog(@"%@", postDataString);
   NSLog(@"------------------------------------------------------------------------");
   */
  
  // check the HTTP method
  STAssertTrue([[urlRequest HTTPMethod] isEqualToString:@"POST"], @"HTTPMethod should be POST");
  
  [postDataString release];
  
  [creds release];
  [request release];
  
}

- (void)testMakeSignedUrlRequestForGET {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodGET credentials:creds];
  
  // add the parameters
  [request.parameters addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [request.parameters addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [request.parameters addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [request.parameters addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [request.parameters addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  
  NSURLRequest *urlRequest = [request makeSignedUrlRequest];
  
  // check the URL (must have parameters appended)
  NSString *actualUrl = [urlRequest.URL absoluteString];
  NSString *expectedUrl = EXPECTED_FULL_URL_FOR_GET;
  
  /*
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Expected URL:");
   NSLog(@"%@", expectedUrl);
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Actual URL:");
   NSLog(@"%@", actualUrl);
   NSLog(@"------------------------------------------------------------------------");
   */
  
  STAssertTrue([actualUrl isEqualToString:expectedUrl], @"Incorrect URL.  Expected '%@' but was '%@'.", expectedUrl, actualUrl);
  
  // check the HTTP method
  STAssertTrue([[urlRequest HTTPMethod] isEqualToString:@"GET"], @"HTTPMethod should be GET");
  
  [creds release];
  [request release];
  
}

- (void)testMakeSignedUrlRequestForPUT {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodPUT credentials:creds];
  
  // add the parameters
  [request.parameters addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [request.parameters addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [request.parameters addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [request.parameters addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [request.parameters addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  
  NSURLRequest *urlRequest = [request makeSignedUrlRequest];
  
  // check the URL
  NSString *actualUrl = [urlRequest.URL absoluteString];
  NSString *expectedUrl = [url absoluteString];
  STAssertTrue([actualUrl isEqualToString:expectedUrl], @"Incorrect URL.  Expected '%@' but was '%@'.", expectedUrl, actualUrl);
  
  // check the HTTP body
  NSData *postData = [urlRequest HTTPBody];
  NSString *postDataString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
  
  STAssertTrue([postDataString isEqualToString:EXPECTED_FINAL_PUT_DATA], @"PUT Post Data incorrect, expected \"%@\" but was \"%@\".", EXPECTED_FINAL_POST_DATA, postDataString);
  
  /*
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Expected Post data:");
   NSLog(@"%@", EXPECTED_FINAL_POST_DATA);
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Actual Post data:");
   NSLog(@"%@", postDataString);
   NSLog(@"------------------------------------------------------------------------");
   */
  
  // check the HTTP method
  STAssertTrue([[urlRequest HTTPMethod] isEqualToString:@"PUT"], @"HTTPMethod should be PUT");
  
  [postDataString release];
  
  [creds release];
  [request release];
  
}

- (void)testMakeSignedUrlRequestForDELETE {
  
  NSURL *url = [NSURL URLWithString:TEST_URL];
  SRCredentials *creds = [[SRCredentials alloc] initWithKey:TEST_KEY secret:TEST_SECRET];
  SRRequest *request = [[SRRequest alloc] initWithUrl:url method:SRRequestMethodDELETE credentials:creds];
  
  // add the parameters
  [request.parameters addValue:PARAM1_VALUE forKey:PARAM1_KEY];
  [request.parameters addValue:PARAM2_VALUE forKey:PARAM2_KEY];
  [request.parameters addValue:PARAM3_VALUE forKey:PARAM3_KEY];
  [request.parameters addValue:PARAM4_VALUE forKey:PARAM4_KEY];
  [request.parameters addValue:PARAM5_VALUE forKey:PARAM5_KEY];
  
  NSURLRequest *urlRequest = [request makeSignedUrlRequest];
  
  // check the URL (must have parameters appended)
  NSString *actualUrl = [urlRequest.URL absoluteString];
  NSString *expectedUrl = EXPECTED_FULL_URL_FOR_DELETE;
  
  /*
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Expected URL:");
   NSLog(@"%@", expectedUrl);
   NSLog(@"------------------------------------------------------------------------");
   NSLog(@"Actual URL:");
   NSLog(@"%@", actualUrl);
   NSLog(@"------------------------------------------------------------------------");
   */
  
  STAssertTrue([actualUrl isEqualToString:expectedUrl], @"Incorrect URL.  Expected '%@' but was '%@'.", expectedUrl, actualUrl);
  
  // check the HTTP method
  STAssertTrue([[urlRequest HTTPMethod] isEqualToString:@"DELETE"], @"HTTPMethod should be DELETE");
  
  [creds release];
  [request release];
  
}

@end

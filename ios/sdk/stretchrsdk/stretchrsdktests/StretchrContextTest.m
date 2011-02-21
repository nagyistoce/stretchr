//
//  StretchrContextTest.m
//  stretchrsdk
//
//  Created by Mat Ryer on 20/Feb/2011.
//

#import "StretchrContextTest.h"
#import "TestHelpers.h"

@implementation StretchrContextTest

- (void)setUp {
  
  NSString *accountName = @"account-name";
  NSString *publicKey = @"public-key";
  NSString *privateKey = @"private-key";
  
  testContext = [[StretchrContext alloc] initWithAccountName:accountName
                                                                publicKey:publicKey
                                                               privateKey:privateKey];
  
}

- (void)tearDown {

  [testContext release];
  testContext = nil;
  
}

#pragma mark - Helper methods

- (StretchrResource*)createTestResource {
  
  NSString *path = @"/tests/1/resources";
  NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"name", @"Mat", @"language", @"en", nil];
  
  StretchrResource *resource = [[[StretchrResource alloc] initWithPath:path andProperties:properties] autorelease];
  
  [properties release];
  
  return resource;
  
}

#pragma mark - Tests

- (void)testInit {
  
  NSString *accountName = @"account-name";
  NSString *publicKey = @"public-key";
  NSString *privateKey = @"private-key";
  
  StretchrContext *context = [[StretchrContext alloc] initWithAccountName:accountName
                                                                publicKey:publicKey
                                                               privateKey:privateKey];
  
  STAssertStringsEqual(context.accountName, accountName, @"context.accountName incorrect");
  STAssertStringsEqual(context.publicKey, publicKey, @"context.publicKey incorrect");
  STAssertStringsEqual(context.privateKey, privateKey, @"context.privateKey incorrect");
  
  STAssertStringsEqual(context.domain, @"stretchr.com", @"context.domain incorrect");
  
  // check initial delegate value is self
  STAssertEquals(context.delegate, context, @".delegate should be set to self initially");
  
  [context release];
  
}

#pragma mark - Properties

- (void)testProperties {
  
  STAssertStringsEqual(testContext.dataType, @"json", @".dataType should default to json");
  
  testContext.dataType = @"xml";
  STAssertStringsEqual(testContext.dataType, @"xml", @".dataType incorrect");
  
}

#pragma mark - URLs

- (void)testServerDomain {
  
  [testContext setUseSsl:NO];
  STAssertStringsEqual([testContext host], @"http://account-name.stretchr.com", @"Return of serverDomain incorrect (http)");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext host], @"https://account-name.stretchr.com", @"Return of serverDomain incorrect (https)");
  
}

- (void)testUrlForResourceWithNewResource { 
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags"];
  
  [testContext setUseSsl:NO];
  
  MRLog([testContext urlForResource:resource]);
  
  STAssertStringsEqual([testContext urlPathForResource:resource], @"http://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext urlPathForResource:resource], @"https://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  
  [resource release];
  
}

- (void)testUrlForResourceWithExistingResource { 
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags" andId:@"lemon"];
  
  [testContext setUseSsl:NO];
  
  STAssertStringsEqual([testContext urlForResource:resource], @"http://account-name.stretchr.com/people/123/tags/lemon.json", @"Return of urlForResource incorrect");
  
  STAssertStringsEqual([testContext urlPathForResource:resource], @"http://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext urlForResource:resource], @"https://account-name.stretchr.com/people/123/tags/lemon.json", @"Return of urlForResource incorrect");
  STAssertStringsEqual([testContext urlPathForResource:resource], @"https://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  
  [resource release];
  
}

#pragma mark - Configuring NSURLRequest objects

- (void)testHttpMethodStringFromStretchrHttpMethod {

  STAssertStringsEqual([testContext httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodPOST], @"POST", @"Return of httpMethodStringFromStretchrHttpMethod incorrect.");
  STAssertStringsEqual([testContext httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodGET], @"GET", @"Return of httpMethodStringFromStretchrHttpMethod incorrect.");
  STAssertStringsEqual([testContext httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodPUT], @"PUT", @"Return of httpMethodStringFromStretchrHttpMethod incorrect.");
  STAssertStringsEqual([testContext httpMethodStringFromStretchrHttpMethod:StretchrHttpMethodDELETE], @"DELETE", @"Return of httpMethodStringFromStretchrHttpMethod incorrect.");
  
}

- (void)testUrlRequestForResource {

  StretchrResource *resource = [self createTestResource];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  STAssertNotNil(request, @"return of stretchrContext:urlRequestForResource: shouldn't be nil");
  
}

- (void)testConfigureRequestToCreateResource {
  
  StretchrResource *resource = [self createTestResource];
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toCreateResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"POST", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources.json", @"request.URL was wrong");
  
  // check the request body data
  
  NSString *postDataString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
  STAssertStringsEqual(postDataString, @"Mat=name&en=language", @"HTTPBody incorrect");
  [postDataString release];
  
}
- (void)testConfigureRequestToReadResource {
  
}
- (void)testConfigureRequestToUpdateResource {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"123"];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toUpdateResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"PUT", @"HTTPMethod incorrect.");
  
  // check the URL
  MRLog([request.URL absoluteString]);
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/123.json", @"request.URL was wrong");
  
  // check the request body data
  
  NSString *postDataString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
  STAssertStringsEqual(postDataString, @"Mat=name&en=language", @"HTTPBody incorrect");
  [postDataString release];
  
}
- (void)testConfigureRequestToDeleteResource {
  
}

@end

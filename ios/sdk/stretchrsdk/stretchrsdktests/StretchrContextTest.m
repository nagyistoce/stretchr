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
  
  /*
   
   By default, we'll use NO delegate and any tests that wish to test
   this functionality should create their own StretchrContext to use.
   
   */
  
  testContext = [[StretchrContext alloc] initWithDelegate:nil
                                              AccountName:accountName
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
  NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Mat", @"name", @"en", @"language", nil];
  
  StretchrResource *resource = [[[StretchrResource alloc] initWithPath:path andProperties:properties] autorelease];
  
  [properties release];
  
  return resource;
  
}

#pragma mark - Tests

- (void)testInit {
  
  NSString *accountName = @"account-name";
  NSString *publicKey = @"public-key";
  NSString *privateKey = @"private-key";
  
  StretchrContext *context = [[StretchrContext alloc] initWithDelegate:self
                                                           AccountName:accountName
                                                             publicKey:publicKey
                                                            privateKey:privateKey];
  
  STAssertStringsEqual(context.accountName, accountName, @"context.accountName incorrect");
  STAssertStringsEqual(context.publicKey, publicKey, @"context.publicKey incorrect");
  STAssertStringsEqual(context.privateKey, privateKey, @"context.privateKey incorrect");
  
  STAssertStringsEqual(context.domain, @"stretchr.com", @"context.domain incorrect");
  
  // check initial delegate value is self
  STAssertEquals(context.delegate, self, @".delegate should be set by initWithDelegate method");
  STAssertEquals(context.requestDelegate, context, @".requestDelegate should be set to self initially");
  STAssertEquals(context.connectionDelegate, context, @".connectionDelegate should be set to self initially");
  
  [context release];
  
}

#pragma mark - Properties

- (void)testProperties {
  
  STAssertStringsEqual(testContext.dataType, @"json", @".dataType should default to json");
  
  testContext.dataType = @"xml";
  STAssertStringsEqual(testContext.dataType, @"xml", @".dataType incorrect");
  
}

#pragma mark - URLs

- (void)testHost {
  
  [testContext setUseSsl:NO];
  STAssertStringsEqual([testContext host], @"http://account-name.stretchr.com", @"Return of serverDomain incorrect (http)");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext host], @"https://account-name.stretchr.com", @"Return of serverDomain incorrect (https)");
  
}

- (void)testHostWithDelegate {
  
  StretchrContext *context = [[StretchrContext alloc] initWithDelegate:self AccountName:@"account" publicKey:@"pub" privateKey:@"priv"];
  
  NSString *host = [context host];
  
  STAssertStringsEqual(host, TEST_HOST_VALUE, @"StretchrContext should have used the host from the delegate, not its own");
  
  [context release];
  
}

- (NSString *)stretchrContext:(StretchrContext *)context willUseHost:(NSString *)host {
  return TEST_HOST_VALUE;
}

- (void)testUrlForResourceWithNewResource { 
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags"];
  
  [testContext setUseSsl:NO];
    
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

- (void)testUrlForResourceWithExistingResourceCollection {
  
  StretchrResource *resource = [[StretchrResource alloc] initWithPath:@"/people/123/tags"];
  
  [testContext setUseSsl:NO];
  
  STAssertStringsEqual([testContext urlForResource:resource], @"http://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  STAssertStringsEqual([testContext urlPathForResource:resource], @"http://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
  
  [testContext setUseSsl:YES];
  STAssertStringsEqual([testContext urlForResource:resource], @"https://account-name.stretchr.com/people/123/tags.json", @"Return of urlForResource incorrect");
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
  STAssertStringsEqual(postDataString, @"language=en&name=Mat", @"HTTPBody incorrect");
  [postDataString release];
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");
  
}

- (void)testConfigureRequestToReadResource {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"123"];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toReadResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"GET", @"HTTPMethod incorrect.");
  
  // check the URL
  MRLog([request.URL absoluteString]);
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/123.json?language=en&name=Mat", @"request.URL was wrong");
  
  STAssertNil(request.HTTPBody, @"HTTPBody should be nil for GET requests (read)");
  
  
}

- (void)testConfigureRequestToReadResourceCollection {
  
  StretchrResource *resource = [self createTestResource];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toReadResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"GET", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources.json?language=en&name=Mat", @"request.URL was wrong");
  
  STAssertNil(request.HTTPBody, @"HTTPBody should be nil for GET requests (read)");
  
  
}

- (void)testConfigureRequestToUpdateResource {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"123"];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toUpdateResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"PUT", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/123.json", @"request.URL was wrong");
  
  // check the request body data
  
  NSString *postDataString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
  STAssertStringsEqual(postDataString, @"language=en&name=Mat", @"HTTPBody incorrect");
  [postDataString release];
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");

  
}
- (void)testConfigureRequestToDeleteResource {

  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"123"];
  
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toDeleteResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"DELETE", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/123.json?language=en&name=Mat", @"request.URL was wrong");
  
  STAssertNil(request.HTTPBody, @"HTTPBody should be nil for GET requests (read)");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");
  
  
}

- (void)testFinishConfigurationForRequest {
  
  StretchrResource *resource = [self createTestResource];
  NSMutableURLRequest *request = [testContext stretchrContext:testContext urlRequestForResource:resource];
  
  [testContext stretchrContext:testContext configureUrlRequest:request toCreateResource:resource];
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"POST", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources.json", @"request.URL was wrong");
  
  // check the request body data
  
  NSString *postDataString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
  STAssertStringsEqual(postDataString, @"language=en&name=Mat", @"HTTPBody incorrect");
  [postDataString release];
  
  [testContext stretchrContext:testContext finishConfigurationForRequest:request];
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

#pragma mark - Creating NSURLRequest objects

- (void)testCreatingRequestForCreate {
  
  StretchrResource *resource = [self createTestResource];
  NSURLRequest *request = [testContext createUrlRequestToCreateResource:resource];
  
  STAssertNotNil(request, @"request shouldn't be nil");
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"POST", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources.json", @"request.URL was wrong");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

- (void)testCreatingRequestForRead {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"246"];
  NSURLRequest *request = [testContext createUrlRequestToReadResource:resource];
  
  STAssertNotNil(request, @"request shouldn't be nil");
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"GET", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/246.json?language=en&name=Mat", @"request.URL was wrong");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

- (void)testCreatingRequestForReadingACollection {
  
  StretchrResource *resource = [self createTestResource];
  NSURLRequest *request = [testContext createUrlRequestToReadResource:resource];
  
  STAssertNotNil(request, @"request shouldn't be nil");
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"GET", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources.json?language=en&name=Mat", @"request.URL was wrong");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

- (void)testCreatingRequestForUpdate {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"357"];
  NSURLRequest *request = [testContext createUrlRequestToUpdateResource:resource];
  
  STAssertNotNil(request, @"request shouldn't be nil");
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"PUT", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/357.json", @"request.URL was wrong");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Type"], @"application/x-www-form-urlencoded", @" Content-Type Header incorrect.");
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

- (void)testCreatingRequestForDelete {
  
  StretchrResource *resource = [self createTestResource];
  [resource setResourceId:@"2468"];
  NSURLRequest *request = [testContext createUrlRequestToDeleteResource:resource];
  
  STAssertNotNil(request, @"request shouldn't be nil");
  
  // check the http method
  STAssertStringsEqual([request HTTPMethod], @"DELETE", @"HTTPMethod incorrect.");
  
  // check the URL
  STAssertStringsEqual([request.URL absoluteString], @"http://account-name.stretchr.com/tests/1/resources/2468.json?language=en&name=Mat", @"request.URL was wrong");
  
  // check the headers
  STAssertStringsEqual([request.allHTTPHeaderFields objectForKey:@"Content-Length"], ([NSString stringWithFormat:@"%d", [request.HTTPBody length]]), @"Content-Length header incorrect");
  
}

#pragma mark - Real testing of RESTful API calls

- (void)testRealRESTfulAPICalls {
  
  /*
   NOTE: using self as the delegate will cause StretchrContext to use the stretchrContext:willUseHost: method of this class
   which uses TEST_HOST_VALUE instead.
   */
  
  StretchrContext *context = [[StretchrContext alloc] initWithDelegate:self AccountName:@"mat" publicKey:@"pub" privateKey:@"priv"];
  
  StretchrResource *googleSearchResource = [[StretchrResource alloc] 
                                            initWithPath:@"/search"
                                           andProperties:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"q", @"monkey", nil]];
  
  NSURLConnection *connection = [context startConnectionToReadResource:googleSearchResource];
  
  MRLog([connection description]);
  
}

/**
 Called when a request connection failed with an error.
 */
- (void)stretchrContext:(StretchrContext*)context connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
 
  MRLog(@"ERROR");
  
}

/**
 Called when a request connection has finished loading.
 */
- (void)stretchrContext:(StretchrContext*)context connectionDidFinishLoading:(NSURLConnection*)connection withResponse:(StretchrResponse*)response {
 
  MRLog(@"SUCCESS");
  
}


@end

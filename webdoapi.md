# `webdo` #



## Anatomy of test suites and tests ##

A webdo test suite is a single ruby (`.rb`) file that contains one or more `test` method calls.  Files must end with `_test.rb` to be recognised by webdo.

### the `test` method ###

```
test "Name your test" do
  # test code
end
```

The test method performs a webdo test when run.  Your test code is usually made up of one or more `web do` calls, followed by a number of assertions.

## `web do` commands - Making web requests ##

The `web do`...`end` block allows you to specify a web request to make.  For example, the following code will make a GET request on `http://www.google.co.uk/search?q=webdo`:

```
  web do
    get
    url "http://www.google.co.uk/search"
    with_param "q", "webdo"
  end
```

All requests must have at least a `url`.

### `get`, `put`, `post`, `delete` (HTTP methods) ###

You can use any one of the four main RESTful HTTP methods:

  * `get`
  * `put`
  * `post`
  * `delete`

The default is `get`.

### `url` ###

```
url "http://www.google.co.uk/search"
```

The `url` method specifies the URL (protocol, domain, path and filename) of the request to make.  Query string parameters are included with the `with_param` method.

### `with_param` ###

```
with_param "q", "webdo"
```

The `with_param` method specifies a parameter to use when making the request.  `get` and `delete` requests will include these parameters in the querystring (after the `?` in the URL), whereas `post` and `put` requests will send it in the request body.

### `with_header` ###

```
with_header "Accept", "application/json"
```

The `with_header` parameter specifies a header to use when making the request.  For a full list of available options, see http://en.wikipedia.org/wiki/List_of_HTTP_header_fields

## Helper methods and objects ##

Along the way, you will have access to a number of useful helper methods that should make writing tests easier.

### `json_response` ###

Returns the response of the last web request as an object.  Will fail if invalid JSON is returned from the server.

### `@request` ###

The most recent (or current) request object.  This must be manipulated within the `web do`...`end` block. although can be read afterwards.

NOTE: This is NOT a HTTPRequest ruby object, instead it is a plain object containing the settings for the request that gets generated when the `web do`...`end` block closes.

### `@response` ###

The most recent HTTP response.  This is actually a [HTTPResponse ruby object](http://www.ensta.fr/~diam/ruby/online/ruby-doc-stdlib/libdoc/net/http/rdoc/classes/Net/HTTPResponse.html).

## Assertion methods ##

After your `web do`...`end` block, you usually want to make assertions about the response that was returned.

### `assert` ###

```
assert 1 == 1, "One should equal one!"
```

The `assert` method is the simplest method for asserting truth.  If the expression passed in as the first argument does not evaluate to true (or truth), the test will fail.

### `fail` ###

```
fail "Something was wrong!"
```

The `fail` method causes the current test to fail.  You must provide a nice message explaining what went wrong in case someone else wants to use your tests later.

### `assert_equal` ###

```
assert_equal 100, 50+50, "Two 50's should be 100 c'mon!"
```

The `assert_equal` method checks that two values are equal (`==`).

### `assert_not_nil` ###

```
assert_not_nil obj, "obj shouldn't be nil"
```

The `assert_not_nil` method checks that a value isn't `nil` and fails if it is.

### `assert_nil` ###

```
assert_nil obj, "Honestly, obj should be nil!"
```

The `assert_nil` method checks that a value is `nil` and fails if it is not.

### `assert_true` ###

```
assert_true something, "Something should be true, I'm sure of it"
```

### `assert_false` ###

```
assert_false something, "something should be false"
```

### `assert_success` ###

Asserts that the response came back with a `200 OK` HTTP status.

### `assert_not_found` ###

Asserts that the response came back with a `404 Not Found` HTTP status.

### `assert_redirect` ###

Asserts that the response came back with a `302 Redirected` HTTP status.

### `assert_created` ###

Asserts that the response came back with a `201 Created` HTTP status.

### `assert_status` ###

```
assert_status 404, "Should be not found after delete"
```

The `assert_status` method checks to ensure the response had a specific status code.  For a complete list of HTTP status codes see http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html

### `assert_response_contains` ###

```
assert_response_contains "John Smith", "Logged in name was not present in the response"
```

The `assert_response_contains` method allows you to check whether a string is present in the response body or not.  If it is not, the assertion will fail.

## Files and the naming convention ##

Webdo follows a simple naming convention when looking for test files.  Following the ruby style, all test files must end in `_test.rb`.  For example:

```
ensure_posting_not_allowed_test.rb
```

Webdo will find and run files in alphabetical order, so it makes sense to use a number prefix system if the order of requests matters to you.

For example:

```
001_delete_resource_test.rb
002_create_new_resource_test.rb
003_get_created_resource_test.rb
```

### Other file types ###

You may also specify `_config.rb`, `_setup.rb` and `_cleanup.rb` files that allow you to run any configuration, setup before the tests or cleanup after the tests are processed.

Files are processed in this order:

| Config files | `_config.rb` |
|:-------------|:-------------|
| Setup files | `_setup.rb` |
| Test files | `_test.rb` |
| Cleanup files | `_cleanup.rb` |

## Global variables ##

While writing your `web do`...`end` blocks, or your assertions (or any other code your tests might perform), you have access to a number of underlying variables that you might care about.

| **Variable** | **Description** |
|:-------------|:----------------|
| `@starttime` | The time the tests started running |
| `@current_file` | The current file name running |
| `@current_test_name` | The name of the current running test |
| `@current_request` | An object describing the request that will be (or was) made |
| `@total_tests` | The number of total tests run so far |
| `@total_assertions` | The number of total assertions run so far |
| `@failed_assertions` | The number of total assertions that have failed so far |
| `@successful_assertions` | The number of total assertions that were successful so far |
| `@failed_tests` | The number of total tests that have failed so far |
| `@successful_tests` | The number of total tests that have been successful so far |
| `@success` | Whether the current test is successful so far or not |
| `@number_of_web_requests` | The total number of web requests made so far |
| `@reported_current_test` | (internal) Whether the current test has been printed out to the user or not |
| `@working_directory` | The directory where webdo started its work |
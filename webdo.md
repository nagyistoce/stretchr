# `webdo` #

## What is `webdo`? ##

We needed a way to test our RESTful API from a totally external point of view.  So we wrote this simple little ruby script that makes it very easy to run real world tests against the real web.

## A simple example? ##

Webdo lets you write tests like this:

```
test "Google search for webdo" do
  
  web do
    get
    url "http://www.google.co.uk/search"
    with_param "q", "webdo"
  end
  
  assert_success
  assert_response_contains "webdo"
  
end
```

### and the output ###

```
Tests:		Total: 1	Success: 1 	Failed: 0	(100% success)
Assertions:	Total: 2	Success: 2	Failed: 0	(100% success)
```

## Get the source ##

  * Feel free to [get the source code](http://code.google.com/p/stretchr/source/browse/#svn%2Ftrunk%2Ftest%2Fruby%2Fwebdo)

## Get started ##

  * [Getting Started with Webdo](webdoGettingStarted.md)
  * [Webdo API Documentation](webdoapi.md)
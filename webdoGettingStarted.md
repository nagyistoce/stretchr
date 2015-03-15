# Getting started with `webdo` #



## 1. Install Ruby ##

  * `webdo` requires [Ruby](http://www.ruby-lang.org/en/downloads/)

## 2. Download `webdo` ##

  * Download the [webdo](http://code.google.com/p/stretchr/source/browse/#svn%2Ftrunk%2Ftest%2Fruby%2Fwebdo%2Fwebdo) folder from the [Downloads](http://code.google.com/p/stretchr/downloads/list) section
  * Optional:  Add webdo to your `$PATH` to make using it easier

## 3. Create a folder for your tests ##

`webdo` works by recursively iterating over files in directories, and all subdirectories too.  So you need to create a top-level folder that holds all your tests and test folders.

## 4. Write a test ##

Create a file called `simple_test.rb` in your test folder and paste the following code:

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

## 5. Run the tests ##

In terminal, navigate to your webdo folder and type:

```
./webdo {path-to-test-folder}
```

alternatively, navigate to your test folder and type:

```
{path-to-webdo-folder}/webdo .
```
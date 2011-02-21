#!/usr/bin/env ruby
require 'net/http'
require 'rubygems'
require 'json'

@current_file = nil
@current_test_name = nil
@current_request = nil
@total_tests = 0
@total_assertions = 0
@failed_assertions = 0
@successful_assertions = 0
@failed_tests = 0
@successful_tests = 0
@success = true
@number_of_web_requests = 0

@last_response = nil

def test(name, &block)
  
  print "."
    
  # new test
  @success = true
  @current_test_name = name
  @total_tests = @total_tests + 1
  
  # run the block
  yield block
  
  if !@success
    @failed_tests = @failed_tests + 1
  else
    @successful_tests = @successful_tests + 1
  end
  
end

def web(&block)
  
  @number_of_web_requests = @number_of_web_requests + 1
  
  # new request
  @current_request = {
    :http_method => :none,
    :url => nil,
    :headers => nil,
    :params => nil
  }
  
  yield block
  
  req = nil
  
  # perform the request
  uri = URI.parse(@current_request[:url])
  http = Net::HTTP.new(uri.host, uri.port)
  case @current_request[:http_method]
  when :get
    req = Net::HTTP::Get.new(uri.path)
    req.set_form_data(@current_request[:params])
    req = Net::HTTP::Get.new( uri.path+ '?' + req.body )
  when :put
    req = Net::HTTP::Put.new(uri.path)
    req.set_form_data(@current_request[:params])
  when :post
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data(@current_request[:params])
  when :delete
    req = Net::HTTP::Delete.new(uri.path)
    req.set_form_data(@current_request[:params])
    req = Net::HTTP::Delete.new( uri.path + '?' + req.body )
  end
  
  @last_response = http.request(req)

end

def print_last_request
  
  # request
  puts ""
  puts "#{@failed_tests+1})\t#{@current_test_name} (#{@current_file})"
  print "\t"
  print @current_request[:http_method].to_s.upcase
  print " "
  print @current_request[:url]

  # parameters
  if @current_request[:params]
    puts ""
    puts "\tParameters:"
    @current_request[:params].each do | k, v |
      puts "\t  #{k}=#{v}"
    end
  end
  
  if @current_request[:headers]
    puts ""
    puts "\tHeaders:"
    @current_request[:headers].each do | k, v |
      puts "\t  #{k}=#{v}"
    end
  end
  
end

# METHODS
def get ; @current_request[:http_method] = :get ; end
def delete ; @current_request[:http_method] = :delete ; end
def put ; @current_request[:http_method] = :put ; end
def post ; @current_request[:http_method] = :post ; end

# PROPERTIES
def url(u); @current_request[:url] = u ; end
def with_header(h, v)
  @current_request[:headers] ||= {}
  @current_request[:headers][h] = v;
end
def with_param(h, v)
  @current_request[:params] ||= {}
  @current_request[:params][h] = v;
end

# RESPONSE
def json_response
  JSON.parse(@last_response.body, { :symbolize_names => true })  
end

# ASSERTIONS
def fail(m)
  @success = false
  
  print_last_request
  puts ""
  puts "Failed :-( - #{m}"
  puts ""
  
end
def assert(e, m = nil)
  @total_assertions = @total_assertions + 1
  if e
    @successful_assertions = @successful_assertions + 1
  else
    @failed_assertions = @failed_assertions + 1
    fail(m)
  end
end
def assert_has_response
  assert(@last_response != nil, " Must perform a 'web do' before making such assertions")
end
def assert_equal(b,a,m=nil)
  assert(a == b, "#{m} (Expected \"#{a}\" but was \"#{b}\")")
end
def assert_not_equal(b, a, m=nil)
  assert(a != b, "#{m} (Expected not to be \"#{a}\")")
end
def assert_nil(a, m=nil)
  assert_equal(a, nil, "#{m} (Expected to be nil)");
end
def assert_not_nil(a, m=nil)
  assert_not_equal(a, nil, "#{m} (Expected NOT to be nil)")
end
def assert_status(s)
  assert_equal(@last_response.code.to_s, s.to_s, " Status should be #{s}")
end
def assert_success
  assert_status(200)
end
def assert_not_found
  assert_status(404)
end
def assert_response_contains(what)
  assert(@last_response.body.include?(what), "The response should contain \"#{what}\" but doesn't");
end

def print_results
  
  tests_success_percentage = 0
  if (@successful_tests > 0)
    tests_success_percentage = 100 / (@total_tests / @successful_tests)
  end
  
  assertions_success_percentage = 0
  if (@successful_assertions > 0)
    assertions_success_percentage = 100 / (@total_assertions / @successful_assertions)
  end
  
  puts ""; puts ""
  puts "Tests:\t\tTotal: #{@total_tests}\tSuccess: #{@successful_tests} \tFailed: #{@failed_tests}\t(#{tests_success_percentage}% success)"
  puts "Assertions:\tTotal: #{@total_assertions}\tSuccess: #{@successful_assertions}\tFailed: #{@failed_assertions}\t(#{assertions_success_percentage}% success)"
  puts ""
  if @failed_assertions > 0
    puts "FAILED!"
    puts ""
  else
    puts "SUCCESS!"
    puts ""
  end
end

Dir.glob("**/*_test.rb").each do | file |
  @current_file = file
  require file
end

print_results()
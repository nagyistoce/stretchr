test "Logging into Twitter" do
  
  # log out of twitter
  web do
    get
    url "http://twitter.com/logout"
  end
  
  # log in
  web do 
    post
    url "https://twitter.com/sessions"
    with_param "session[username_or_email]", "email"
    with_param "session[password]", "password"
    with_param "remember_me", "1"
  end
  
  # make sure we are redirected
  assert_redirect
  
  #... and that the response contains a nice message
  assert_response_contains "You are being <a href=\"http://twitter.com/\">redirected</a>."
  
  
  puts "(NOTE: You must modify the logging_into_twitter_test.rb file to include your actual username and password)"
  
  
end
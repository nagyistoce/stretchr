test "Searching for @matryer on Twitter" do
  
  web do
    get
    url "http://search.twitter.com/search.json"
    with_param "q", "@matryer"
  end
  
  assert_success
  assert_equal json_response[:query], "%40matryer"
  
end
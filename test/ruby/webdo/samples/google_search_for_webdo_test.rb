test "Google search for webdo" do
  
  web do
    get
    url "http://www.google.co.uk/search"
    with_param "q", "webdo"
  end
  
  assert_success
  assert_response_contains "webdo"
  
end
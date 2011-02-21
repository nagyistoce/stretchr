test "Getting Google Homepage" do
  
  web do
    get
    url "http://www.google.co.uk/search"
    with_param "q", "matryer"
  end
  
  assert_success
  
end
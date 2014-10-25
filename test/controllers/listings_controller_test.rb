require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end
   
   TESTSERVERURL = ENV["TEST_SERVER"]  
   def create_user_helper(json_array, reset=true)
      # Clean database
      Curl::Easy.http_get(TESTSERVERURL + "/api/TESTAPI_resetUserFixture") if reset
      return Curl::Easy.http_post("http://localhost:3000/api/create_user", json_array) do |curl|
         curl.headers['Content-Type'] = 'application/json'
         curl.enable_cookies = true 
      end
   end

   #Post request for login
   def login_user_helper(json_array)
      return Curl::Easy.http_post(TESTSERVERURL + "/api/login", json_array) do |curl|
         curl.headers['Content-Type'] = 'application/json'
      end
   end

   #Get request for logout
   def signout_user_helper()
      return Curl::Easy.http_get(TESTSERVERURL + "/api/signout")
   end
   
   def create_listing_helper(json_array, reset=true)
      return Curl::Easy.http_post("http://localhost:3000/api/create_listing", json_array) do |curl|
         curl.headers['Content-Type'] = 'application/json'
         curl.enable_cookies = true 
      end
   end
   
   test "valid create listing" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "0" }.to_json 
      response = create_user_helper(my_array)     
      assert(JSON.parse(response.body)["status"].equal? 1)
      cookies['username'] = "Valid Username"

      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createListing, { listing: { title: 'Title1111', \
                   width: 1, height: 1, \
                   time_per_click: 1, \
                   views_per_week: 1, \
                   cost_per_week: 1, \
                   street: "640 Dory Lane", \
                   city: "Redwood City", \
                   state: "CA", \
                   zip: "94065" } }, headers
      assert_response :success           
      assert(JSON.parse(response.body)["status"].equal? 1)
   end

   test "valid advertiser signup" do
   end  
 
end

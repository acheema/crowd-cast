require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end
   
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
      Curl::Easy.http_get(TESTSERVERURL + "/api/TESTAPI_resetListingsFixture") if reset
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
                   usertype: "1" }.to_json
      response = create_user_helper(my_array)
      assert(JSON.parse(response.body)["status"].equal? 1)
      
   end

   test "valid advertiser signup" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "0" }.to_json 
      response = create_user_helper(my_array)     
      assert(JSON.parse(response.body)["status"].equal? 1)
   end
   
end

# Written by Jhoong
require 'test_helper'

class ListingsIntegrationControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

   TESTSERVERURL = ENV["TEST_SERVER"]  
   

   def get_listings_helper(json_array, reset=true)
      return Curl::Easy.http_post(TESTSERVERURL + "/api/get_listings", json_array) do |curl|
         curl.headers['Content-Type'] = 'application/json'
         curl.enable_cookies = true 
      end
   end

   
   test 'valid create listing' do
      get 'api/TESTAPI_resetUserFixture'
      get 'api/TESTAPI_resetListingsFixture' 
      post 'api/create_user', { user: { username: '1234567890', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "1" }}
      post 'api/create_listing', { "HTTP_COOKIE" => "username=1234567890;", \
                                   listing: { title: 'Title1111', \
                                              width: 1, height: 1, \
                                              time_per_click: 1, \
                                              views_per_week: 1, \
                                              cost_per_week: 1, \
                                              street: "640 Dory Lane", \
                                              city: "Redwood City", \
                                              state: "CA", \
                                              zip: "94065" }}
      assert(Listing.all.count == 1)
      assert_equal 200, status
   end

   test 'invalid create listing' do
      get 'api/TESTAPI_resetUserFixture'
      get 'api/TESTAPI_resetListingsFixture' 
      post 'api/create_user', { user: { username: '1234567890', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "1" }}
      post 'api/create_listing', { "HTTP_COOKIE" => "username=1234567890;", \
                                   listing: { title: 'Title1111', \
                                              width: 1, height: 1, \
                                              views_per_week: 1, \
                                              cost_per_week: 1, \
                                              street: "640 Dory Lane", \
                                              city: "Redwood City", \
                                              state: "CA", \
                                              zip: "94065" }}
      assert(Listing.all.count == 0)
   end
   
   test 'valid get listings' do
      get 'api/TESTAPI_resetUserFixture'
      get 'api/TESTAPI_resetListingsFixture' 
      post 'api/create_user', { user: { username: '1234567890', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "1" }}
      post 'api/create_listing', { "HTTP_COOKIE" => "username=1234567890;", \
                                   listing: { title: 'Title1111', \
                                              width: 1, height: 1, \
                                              views_per_week: 1, \
                                              cost_per_week: 1, \
                                              street: "640 Dory Lane", \
                                              city: "Redwood City", \
                                              state: "CA", \
                                              zip: "94065" }}
      my_array = { city: 'Redwood City' }.to_json 
      response = get_listings_helper(my_array)     
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert(JSON.parse(response.body)["listings"].count 1)
   end
 
end

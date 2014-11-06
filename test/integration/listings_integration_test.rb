# Written by Jhoong
require 'test_helper'

class ListingsIntegrationControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def json_response
      ActiveSupport::JSON.decode @response.body
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
                                              zip: "94065", \
                                              screen_resolution_x: 45, \
                                              screen_resolution_y: 45}}
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
                                              zip: "94065", \
                                              screen_resolution_x: 45, \
                                              screen_resolution_y: 45}}
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
                                              zip: "94065", \
                                              screen_resolution_x: 45, \
                                              screen_resolution_y: 45}}
      post 'api/get_listings', { listing: { city: 'Redwood City' } }
      assert(json_response["status"].equal? 1)
      assert(json_response["listings"].count 1)
   end
 
end

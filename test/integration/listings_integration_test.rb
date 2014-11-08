# Written by Jhoong
require 'test_helper'

class ListingsIntegrationControllerTest < ActionDispatch::IntegrationTest
   def json_response
      ActiveSupport::JSON.decode @response.body
   end

   def setup 
      post 'api/create_user', { user: { username: '1234567890', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "1" }}
   end
   
   test 'valid create listing' do
      post 'api/create_listing', { 
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
      assert json_response["status"] >= 0
   end

   test 'invalid create listing' do
      post 'api/create_listing', {
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
      assert(json_response["status"] == -4)
   end
   
   test 'valid get listings' do
      post 'api/create_listing', { 
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
      post 'api/get_listings', { listing: { city: 'Redwood City' } }
      assert(json_response["status"].equal? 1)
      assert(json_response["listings"].count 1)
   end
 
end

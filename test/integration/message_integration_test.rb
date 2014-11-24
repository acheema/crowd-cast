# Written by Jhoong
require 'test_helper'

class MessageIntegrationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def json_response
      ActiveSupport::JSON.decode @response.body
   end

   def setup
      post 'api/create_user', { user: { username: 'valid_username', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "1" }}
      post 'api/create_listing', { listing: { title: 'Title1111', \
                                              width: 1, height: 1, \
                                              time_per_click: 1, \
                                              views_per_week: 1, \
                                              cost_per_day: 1, \
                                              street: "640 Dory Lane", \
                                              city: "Redwood City", \
                                              state: "CA", \
                                              zip: "94065", \
                                              screen_resolution_x: 45, \
                                              screen_resolution_y: 45}}
      @status = json_response['status']
      post 'api/create_user', { user: { username: 'valid_username2', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "0" }}
   end
      
   test 'valid send message' do
      post 'api/send_message', { message: { to_username: 'valid_username', \
                                            text: 'Valid text', \
                                            listing_id: @status, \
                                            listing_title: 'Title1111' } }
      assert json_response['status'] == 1
   end

   test 'invalid to_username' do
      post 'api/send_message', { message: { to_username: 'invalid_valid_username', \
                                            text: 'Valid text', \
                                            listing_id: @status, \
                                            listing_title: 'Title1111' } }
      assert json_response['status'] == -1
   end

   test 'invalid from_username' do
      get 'api/signout'
      post 'api/send_message', { message: { to_username: 'valid_username', \
                                            text: 'Valid text', \
                                            listing_id: @status, \
                                            listing_title: 'Title1111' } }
      assert json_response['status'] == -2
   end

   test 'invalid text' do
      post 'api/send_message', { message: { to_username: 'valid_username', \
                                            text: 'a', \
                                            listing_id: @status, \
                                            listing_title: 'Title1111' } }
      assert json_response['status'] == -3
   end
   
   test 'invalid listing_id' do
      post 'api/send_message', { message: { to_username: 'valid_username', \
                                            text: 'Valid text', \
                                            listing_title: 'Title1111' } }
      assert json_response['status'] == -5
   end
   
   test 'invalid listing_title' do
      post 'api/send_message', { message: { to_username: 'valid_username', \
                                            text: 'Valid text', \
                                            listing_id: @status } }
      assert json_response['status'] == -6
   end
end

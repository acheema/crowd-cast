# Written by Jhoong
require 'test_helper'

class ReservationIntegrationTest < ActionDispatch::IntegrationTest
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
      @listing_id = json_response['status']
      get 'api/signout'
      post 'api/create_user', { user: { username: 'valid_username2', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "0" }}
      post 'api/create_ad', { advertisement: { title: 'Title1111', \
                                               width: 1, height: 1 } }
      @advertisement_id = json_response['status']
   end
      
   test 'valid reservation' do
      post '/reservations', { reservation: { listing_id: @listing_id, \
                                              advertisement_id: @advertisement_id, \
                                              dates: [ {start_date: '2014-11-12', end_date: '2014-11-13', price: 14},
                                                       {start_date: '2014-11-13', end_date: '2014-11-14', price: 15}] } } 
      assert json_response['status'] == 1
   end

   test 'invalid reservation' do
      post '/reservations', { reservation: { listing_id: @listing_id, \
                                              advertisement_id: @advertisement_id, \
                                              dates: [ {start_date: '-2014-11-12', end_date: '2014-11-13', price: 14}] } } 
      assert json_response['status'] == -1
   end
   
   test 'too many reservations' do
      8.times do |i|
         post '/reservations', { reservation: { listing_id: @listing_id, \
                                                 advertisement_id: @advertisement_id, \
                                                 dates: [ {start_date: '2014-11-12', end_date: '2014-11-13', price: 14}] } } 
      end
      assert json_response['status'] == 1
      post '/reservations', { reservation: { listing_id: @listing_id, \
                                              advertisement_id: @advertisement_id, \
                                              dates: [ {start_date: '2014-11-12', end_date: '2014-11-13', price: 14}] } } 
      assert json_response['status'] == -1
      assert json_response['conflicts'].count == 1
   end

   test 'valid get' do
      get '/api/reservations', { listing_id: @listing_id, \
                             start_date: '2014-11-12', \
                             end_date: '2014-11-13' } 
      assert json_response['status'] == -1
      post '/reservations', { reservation: { listing_id: @listing_id, \
                                              advertisement_id: @advertisement_id, \
                                              dates: [ {start_date: '2014-11-04', end_date: '2014-11-13', price: 14}] } } 
      post '/reservations', { reservation: { listing_id: @listing_id, \
                                              advertisement_id: @advertisement_id, \
                                              dates: [ {start_date: '2014-11-12', end_date: '2014-11-13', price: 14}] } } 
      get '/api/reservations', { listing_id: @listing_id, \
                             start_date: '2014-11-10', \
                             end_date: '2014-11-20' } 
      assert json_response.count == 2
      assert json_response[0] == {"start"=>"2014-11-04", "end"=>"2014-11-13"}
      assert json_response[1] == {"start"=>"2014-11-12", "end"=>"2014-11-13"}
   end
   
   test 'invalid get' do
      get '/api/reservations', { listing_id: @listing_id, \
                             start_date: '-2014-11-12', \
                             end_date: '2014-11-13' } 
      assert json_response['status'] == -1
   end
end

# Written by Jhoong
require 'test_helper'

class AdvertisementIntegrationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
   def json_response
      ActiveSupport::JSON.decode @response.body
   end

   def setup
      post 'api/create_user', { user: { username: 'valid_username', password: 'vPassword', email: 'validemail@gmail.com', company: '', usertype: "0" }}
   end
      
   test 'valid create ad' do
      post 'api/create_ad', { advertisement: { title: 'Title1111', \
                                         width: 1, height: 1 } }
      assert json_response['status'] >= 0
   end

   test 'invalid title' do
      post 'api/create_ad', { advertisement: { title: '', \
                                               width: 1, height: 1 } }
      assert json_response['status'] == -1
   end

   test 'invalid advertiser_id' do
      get 'api/signout'
      post 'api/create_ad', { advertisement: { title: 'title', \
                                               width: 1, height: 1 } }
      assert json_response['status'] == -4
   end

   test 'invalid height' do
      post 'api/create_ad', { advertisement: { title: 'title', \
                                               width: 1 } }
      assert json_response['status'] == -2
   end
   
   test 'invalid width' do
      post 'api/create_ad', { advertisement: { title: 'title', \
                                               height: 1 } }
      assert json_response['status'] == -3
   end
end

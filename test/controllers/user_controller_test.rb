require 'test_helper'
require 'json'

class UserControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "create valid owner" do
      assert_nil(cookies[:username])
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "1" } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert_not_nil(cookies[:username])
   end

   test "create valid advertiser" do
      assert_nil(cookies[:username])
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "0" } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert_not_nil(cookies[:username])
   end
   
   test "create invalid owner" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      json = { user: { username: 'Valid Username', \
                       password: 'Valid Password', \
                       email: 'validpassword@gmail.com', \
                       company: 'Some company', \
                       usertype: "1" } }

      #Bad username
      clone = json.deep_dup
      clone[:user][:username] = ''
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -2)
  
      #Bad password
      clone = json.deep_dup
      clone[:user][:password] = ''
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -3)
     
      #Bad email 
      clone = json.deep_dup
      clone[:user][:email] = 'invalidmail.com'
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -4)
      
      #Already existing username
      clone = json.deep_dup
      clone[:user][:usertype] = '0'
      post :createUser, clone, headers
      
      post :createUser, json, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -1)
   end

   test "create invalid advertiser" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      json = { user: { username: 'Valid Username', \
                       password: 'Valid Password', \
                       email: 'validpassword@gmail.com', \
                       company: 'Some company', \
                       usertype: "0" } }
      
      #Bad username
      clone = json.deep_dup
      clone[:user][:username] = ''
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -2)
  
      #Bad password
      clone = json.deep_dup
      clone[:user][:password] = ''
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -3)
     
      #Bad email 
      clone = json.deep_dup
      clone[:user][:email] = 'invalidmail.com'
      post :createUser, clone, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -4)
      
      #Already existing username
      clone = json.deep_dup
      clone[:user][:usertype] = '1'
      post :createUser, clone, headers
      
      post :createUser, json, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -1)
   end

   test "successful owner login" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "1" } }, headers
      get :signoutUser
      assert_nil(cookies[:username])
      
      post :loginUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password' } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert_not_nil(cookies[:username])
   end   

   test "successful advertiser login" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "0" } }, headers

      get :signoutUser
      assert_nil(cookies[:username])
      
      post :loginUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password' } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert_not_nil(cookies[:username])
   end   
   
   test "fail login" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "0" } }, headers
      
      post :loginUser, { user: { username: 'Invalid Username', \
                                  password: 'Valid Password' } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -1)
      post :loginUser, { user: { username: 'Valid Username', \
                                  password: 'Invalid Password' } }, headers
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? -1)
  end 

   test "successful signout" do
      headers = { 'CONTENT_TYPE' => 'application/json' } 
      post :createUser, { user: { username: 'Valid Username', \
                                  password: 'Valid Password', \
                                  email: 'validpassword@gmail.com', \
                                  company: 'Some company', \
                                  usertype: "1" } }, headers
      assert_not_nil(cookies[:username])
      
      get :signoutUser
      assert_response :success
      assert(JSON.parse(response.body)["status"].equal? 1)
      assert_nil(cookies[:username])
   end
end

# Written by Jhoong Roh
require 'test_helper'
require 'json'
require 'curb'

class UserControllerTest < ActionController::TestCase 

   TESTSERVERURL = ENV["TEST_SERVER"]  

   #Post request for sign up
   def create_user_helper(json_array, reset=true)
      # Clean database
      Curl::Easy.http_get(TESTSERVERURL + "/api/TESTAPI_resetUserFixture") if reset
      return Curl::Easy.http_post("http://localhost:3000/api/create_user", json_array) do |curl|
         curl.headers['Content-Type'] = 'application/json'
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
   
   test "valid owner signup" do
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
   
   test "invalid owner signup" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "1" }

      #Bad username
      clone = my_array.deep_dup
      clone[:username] = ''
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -2)
  
      #Bad password
      clone = my_array.deep_dup
      clone[:password] = ''
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -3)
     
      #Bad email 
      clone = my_array.deep_dup
      clone[:email] = 'invalidmail.com'
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -4)
      
      #Already existing username
      clone = my_array.deep_dup
      clone[:usertype] = '0'
      response = create_user_helper(clone.to_json)
      
      response = create_user_helper(my_array.to_json, false)
      assert(JSON.parse(response.body)["status"].equal? -1)
   end

   test "create invalid advertiser" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "0" }

      #Bad username
      clone = my_array.deep_dup
      clone[:username] = ''
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -2)
  
      #Bad password
      clone = my_array.deep_dup
      clone[:password] = ''
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -3)
     
      #Bad email 
      clone = my_array.deep_dup
      clone[:email] = 'invalidmail.com'
      response = create_user_helper(clone.to_json)
      assert(JSON.parse(response.body)["status"].equal? -4)
      
      #Already existing username
      clone = my_array.deep_dup
      clone[:usertype] = '1'
      response = create_user_helper(clone.to_json)
      
      response = create_user_helper(my_array.to_json, false)
      assert(JSON.parse(response.body)["status"].equal? -1)
   end

   test "valid owner login" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "1" }.to_json
      response = create_user_helper(my_array)
          
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password' }.to_json
      response = login_user_helper(my_array)
      assert(JSON.parse(response.body)["status"].equal? 1)
   end   

   test "valid advertiser login" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "0" }.to_json
      response = create_user_helper(my_array)
          
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password' }.to_json
      response = login_user_helper(my_array)
      assert(JSON.parse(response.body)["status"].equal? 1)
   end   
   
   test "invalid login" do
      my_array = { username: 'Valid Username', \
                   password: 'Valid Password', \
                   email: 'validpassword@gmail.com', \
                   company: 'Some company', \
                   usertype: "0" }.to_json
      response = create_user_helper(my_array)
      
      my_array = { username: 'Invalid Username', \
                   password: 'Valid Password' }.to_json
      response = login_user_helper(my_array)
      assert(JSON.parse(response.body)["status"].equal? -1)
      
      my_array = { username: 'Valid Username', \
                   password: 'Invalid Password' }.to_json
      response = login_user_helper(my_array)
      assert(JSON.parse(response.body)["status"].equal? -1)
   end 

end

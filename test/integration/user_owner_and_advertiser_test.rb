require 'test_helper'

class UserOwnerAndAdvertiserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "valid owner can add advertiser type" do
	post '/api/create_user',  { user: { username: "John Doe1", \
									 password: "password", \
									 email: "asdf@asdf.com", \
									 company: 'my comp', \
           						     usertype: '1' }}
  	assert_difference "Advertiser.count()", 1 do
  		post '/api/create_user', {user: { username: "John Doe1", \
	  									 password: "password", \
	  									 email: "asdf@asdf.com", \
	  									 company: 'my comp', \
		           						 usertype: '2' }}, \
		           				{ "HTTP_COOKIE" => "usertype=1;" }
  	end
  end

  test "valid advertiser can add owner type" do
	post '/api/create_user',  { user: { username: "John Doe2", \
									 password: "password", \
									 email: "asdf@asdf.com", \
									 company: 'my comp', \
           						     usertype: '0' }}
  	assert_difference "Owner.count()", 1 do
  		post '/api/create_user', {user: { username: "John Doe2", \
	  									 password: "password", \
	  									 email: "asdf@asdf.com", \
	  									 company: 'my comp', \
		           						 usertype: '2' }}, \
		           				{ "HTTP_COOKIE" => "usertype=0;" }
  	end
  end
end

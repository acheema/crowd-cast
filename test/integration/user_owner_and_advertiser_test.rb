#written by Jason Clark
require 'test_helper' 

class UserOwnerAndAdvertiserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "valid owner can add advertiser type" do
	post '/api/create_user',  { user: { username: "JohnDoe1", \
									 password: "password1", \
									 email: "asdf@asdf.com", \
									 company: 'my comp', \
           						     usertype: '1' }}
  	assert_difference "Advertiser.count()", 1 do
  		post '/api/create_user', {user: { usertype: '2' }}, \
		           				{ "HTTP_COOKIE" => "usertype=1; username=JohnDoe1;" }
  	end
  end

  test "valid advertiser can add owner type" do
	post '/api/create_user',  { user: { username: "JohnDoe2", \
									 password: "password1", \
									 email: "asdf@asdf.com", \
									 company: 'my comp', \
           						     usertype: '0' }}
  	assert_difference "Owner.count()", 1 do
  		post '/api/create_user', {user: { usertype: '2' }}, \
		           				{ "HTTP_COOKIE" => "usertype=0; username=JohnDoe2;" }
  	end
  end
end

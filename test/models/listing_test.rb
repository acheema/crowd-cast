require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
  	@owner = Owner.create(:username => "Username1234", :password => "password", :email => "email@crowdcast.com", :company => "hello5")
    @params = {
    	title: "Listing 1", 
    	height: 30, 
    	width: 31, 
    	time_per_click: 8, 
		views_per_week: 8, 
		cost_per_week: 100, 
		street: "College Ave", 
		city: "Berkeley", 
		state: "CA", 
		zip: "94704", 
		owner: @owner
	}
  end 

  test 'should be valid' do
    response = Listing.createListing(@params)
    assert_equal 1, response 
  end 

  test "Not sending a title, give error" do
    @params[:title] = ""
    response = Listing.createListing(@params)
    assert_equal -1, response 
  end

  test "Sending a string height should fail, give error" do
    @params[:height] = "2"
    response = Listing.createListing(@params)
    assert_equal -2, response 
  end

  test "Sending a string width should fail, give error" do
    @params[:width] = "2"
    response = Listing.createListing(@params)
    assert_equal -3, response 
  end

  test "Not sending a height, give error" do
    @params.delete :height
    response = Listing.createListing(@params)
    assert_equal -2, response 
  end


  test "Not sending a time_per_click, give error" do
    @params.delete :time_per_click
    response = Listing.createListing(@params)
    assert_equal -4, response 
  end

  test "sending a non-integer time_per_click, give error" do
    @params[:time_per_click] = "89"
    response = Listing.createListing(@params)
    assert_equal -4, response 
  end

  test "Not sending a views_per_week, give error" do
    @params.delete :views_per_week
    response = Listing.createListing(@params)
    assert_equal -5, response 
  end

  test "sending a non-integer views_per_week, give error" do
    @params[:views_per_week] = "89"
    response = Listing.createListing(@params)
    assert_equal -5, response 
  end

  test "Not sending a cost_per_week, give error" do
    @params.delete :cost_per_week
    response = Listing.createListing(@params)
    assert_equal -6, response 
  end

  test "Not sending a street, give error" do
    @params.delete :street
    response = Listing.createListing(@params)
    assert_equal -7, response 
  end

  test "Not sending a city, give error" do
    @params.delete :city
    response = Listing.createListing(@params)
    assert_equal -8, response 
  end

  test "Not sending a state, give error" do
    @params.delete :state
    response = Listing.createListing(@params)
    assert_equal -9, response 
  end

  test "Not sending a zip, give error" do
    @params.delete :zip
    response = Listing.createListing(@params)
    assert_equal -10, response 
  end  

  test "Not sending an owner, give error" do 
  	@params.delete :owner 
  	response = Listing.createListing(@params)
  	assert_equal -11, response
  end
end

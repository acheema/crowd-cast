# Written by Sukriti
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
		cost_per_day: 100, 
		street: "College Ave", 
		city: "Berkeley", 
		state: "CA", 
		zip: "94704", 
		owner: @owner,
      screen_resolution_x: 56,
      screen_resolution_y: 57,
	   active: true,
      views: 0
   }
  end 

  test 'should be valid' do
    assert Listing.new(@params).valid?
  end 

  test "Not sending a title, give error" do
    @params[:title] = ""
    response = Listing.createListing(@params)
    assert_equal -1, response 
  end

  test "Not sending a height, give error" do
    @params.delete :height
    response = Listing.createListing(@params)
    assert_equal -2, response 
  end

  test "Not sending a width, give error" do
    @params.delete :width
    response = Listing.createListing(@params)
    assert_equal -3, response 
  end
  
  test "Not sending a time_per_click, give error" do
    @params.delete :time_per_click
    response = Listing.createListing(@params)
    assert_equal -4, response 
  end

  test "sending a non-integer time_per_click, give error" do
    @params[:time_per_click] = 89.9
    response = Listing.createListing(@params)
    assert_equal -4, response 
  end

  test "Not sending a views_per_week, give error" do
    @params.delete :views_per_week
    response = Listing.createListing(@params)
    assert_equal -5, response 
  end

  test "sending a non-integer views_per_week, give error" do
    @params[:views_per_week] = 89.9
    response = Listing.createListing(@params)
    assert_equal -5, response 
  end

  test "Not sending a cost_per_day, give error" do
    @params.delete :cost_per_day
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
  
  test "Not sending a screen_resolution_x, give error" do 
  	@params.delete :screen_resolution_x 
  	response = Listing.createListing(@params)
  	assert_equal -12, response
  end
  
  test "Not sending a screen_resolution_y, give error" do 
  	@params.delete :screen_resolution_y
  	response = Listing.createListing(@params)
  	assert_equal -13, response
  end

   test "valid get listings" do
      params2 = {
         title: "Listing 2", 
         height: 30, 
         width: 31, 
         time_per_click: 8, 
         views_per_week: 8, 
         cost_per_day: 100, 
         street: "College Ave", 
         city: "SF", 
         state: "CA", 
         zip: "94704", 
         owner: @owner,
         screen_resolution_x: 56,
         screen_resolution_y: 57
      }
      response1 = Listing.createListing(@params)
      response2 = Listing.createListing(params2)
      listing2 = Listing.find(response2)
      response = Listing.getListings("SF")
      assert_equal [listing2], response
  end 

  test "more valid get listings" do
    params2 = {
      title: "Listing 2", 
      height: 30, 
      width: 31, 
      time_per_click: 8, 
      views_per_week: 8, 
      cost_per_day: 100, 
      street: "College Ave", 
      city: "SF", 
      state: "CA", 
      zip: "94704", 
      owner: @owner,
      screen_resolution_x: 56,
      screen_resolution_y: 57
    }
    params3 = {
      title: "Listing 3", 
      height: 30, 
      width: 31, 
      time_per_click: 8, 
      views_per_week: 8, 
      cost_per_day: 100, 
      street: "Bancroft Ave", 
      city: "SF", 
      state: "CA", 
      zip: "94704", 
      owner: @owner,
      screen_resolution_x: 56,
      screen_resolution_y: 57
    }
    Listing.createListing(@params)
    response2 = Listing.createListing(params2)
    response3 = Listing.createListing(params3)
    listing2 = Listing.find(response2)
    listing3 = Listing.find(response3)
    response = Listing.getListings("SF")

    assert_equal [listing2, listing3], response
  end 
end

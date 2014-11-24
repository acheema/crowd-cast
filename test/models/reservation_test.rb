# Written by Jhoong
require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
   
  def setup
    params = { username: "Valid Username", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    @advertiser = Advertiser.create(params)
  	 params = {:username => "Username1234", :password => "password", :email => "email@crowdcast.com", :company => "hello5"}
  	 @owner = Owner.create(:username => "Username1234", :password => "password", :email => "email@crowdcast.com", :company => "hello5")
    params = { title: "Listing 1", height: 30, width: 31, time_per_click: 8, views_per_week: 8, cost_per_day: 100, 
		street: "College Ave", city: "Berkeley", state: "CA", zip: "94704", owner: @owner, screen_resolution_x: 56,
      screen_resolution_y: 57, active: true, views: 0 }
    @listing = Listing.create(params)
    params = { title: "A valid title", height: 30, width: 31, advertiser: @advertiser }     
    @advertisement = Advertisement.create(params)
    @params = { start_date: "2014-11-12", end_date: "2014-11-30", price: 14, completed: false, order: "1",
               advertiser: @advertiser, advertisement: @advertisement, listing: @listing }     
  end
   
  test "valid reservation" do
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
  end
  
  test "invalid reservation" do
      @params[:start_date] = "-1-1-1" 
      assert_equal(true, Reservation.create(@params).errors.any?, "invalid reservation")
      @params[:end_date] = "-1-1-1" 
      assert_equal(true, Reservation.create(@params).errors.any?, "invalid reservation")
  end

  test "too many reservations in a day" do
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(true, Reservation.create(@params).errors[:full_dates].any?, "invalid reservation")
  end

  test "get reservations" do
     assert_equal(false, Reservation.create(@params).errors.any?, "valid reservation")
     assert_equal(true, Reservation.get(listing: @listing, start_date: @params[:start_date], end_date: @params[:end_date]).any?, "valid get")
     assert_equal(1, Reservation.get(listing: @listing, start_date: @params[:start_date], end_date: @params[:end_date]).count, "valid get")
     assert_equal(false, Reservation.get(listing: @listing, start_date: "3014-11-11", end_date: "3014-11-11").any?, "valid get")
  end

  test "invalid get reservations" do
     assert_equal(nil, Reservation.get(listing: @listing, start_date: "-3014-11-11", end_date: "3014-11-11"), "valid get")
  end

  test "valid complete payments" do
     reservation = Reservation.create(@params)
     order = reservation.order
     assert_equal(false, reservation.completed, "should not be completed")
     Reservation.completePayment(order)
     completed_reservation = Reservation.find(reservation.id)
     assert_equal(true, completed_reservation.completed, "should be completed") 
  end
end

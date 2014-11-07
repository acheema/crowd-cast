# Written by Jhoong
require 'test_helper'

class AdvertisementTest < ActiveSupport::TestCase
  def setup
    params = { username: "Valid Username", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    @advertiser = Advertiser.create(params)
 end
   
  test "invalid title" do
     params = { title: "", height: 30, width: 31, advertiser: @advertiser }     
     assert_equal(-1, Advertisement.createAd(params), "invalid title")
  end

  test "invalid height" do
     params = { title: "Advertisement 1", height: "a", width: 31, advertiser: @advertiser }     
     assert_equal(-2, Advertisement.createAd(params), "invalid height")
  end

  test "invalid width" do
     params = { title: "Advertisement 1", height: 30, width: "a", advertiser: @advertiser }     
     assert_equal(-3, Advertisement.createAd(params), "invalid width")
  end

  test "invalid advertiser" do
     params = { title: "Advertisement 1", height: 30, width: 31 }     
     assert_equal(-4, Advertisement.createAd(params), "invalid advertiser")
  end

  test "valid advertisement" do
     params = { title: "Advertisement 1", height: 30, width: 31, advertiser: @advertiser }     
     assert 0 <= Advertisement.createAd(params)
  end

  test "invalid getAds" do
     params = { title: "Advertisement 1", height: 30, width: 31, advertiser: @advertiser }     
     Advertisement.createAd(params)
     assert_equal( false, Advertisement.getAds(-1).any?, "invalid getAds" ) 
  end

  test "valid getAds" do
     params = { title: "Advertisement 1", height: 30, width: 31, advertiser: @advertiser }     
     Advertisement.createAd(params)
     assert_equal(params[:title], Advertisement.getAds(@advertiser.id)[0].title, "title") 
     assert_equal(params[:height], Advertisement.getAds(@advertiser.id)[0].height, "height") 
     assert_equal(params[:width], Advertisement.getAds(@advertiser.id)[0].width, "width") 
   end

end

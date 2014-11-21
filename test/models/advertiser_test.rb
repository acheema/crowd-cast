# Written by Jhoong Roh and Jason Clark (last two tests)
require 'test_helper'

class AdvertiserTest < ActiveSupport::TestCase

  test "invalid createUser username field" do
    #Blank username
    params = { username: "", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-2, Advertiser.createUser(params), "Username is blank.")

    #Short username
    params = { username: "a", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-2, Advertiser.createUser(params), "Username is too short.")

    #Short username
    params = { username: "a" * 5, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-2, Advertiser.createUser(params), "Username is too short.")

    #Long username
    params = { username: "a" * 129, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-2, Advertiser.createUser(params), "Username is too long.")

    #Already existing Advertiser username
    params = { username: "Valid Username", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params).username, "Username should be 'Valid Username'")
    params = { username: "Valid Username", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-1, Advertiser.createUser(params), "Username already exists")

    #Already existing Owner username
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username 2", Owner.createUser(params).username, "Username should be 'Valid Username'")
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-1, Advertiser.createUser(params), "Username already exists")
  end

  test "valid createUser username field" do
    #Valid username
    params = { username: "a" * 6, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("a" * 6, Advertiser.createUser(params).username, "Username should be 6 'a's")
    params = { username: "a" * 128, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("a" * 128, Advertiser.createUser(params).username, "Username should be 128 'a's")
  end

  test "invalid createUser password field" do
    #Blank password
    params = { username: "Valid Username", password: "", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is blank.")

    #Short password
    params = { username: "Valid Username", password: "a" * 7, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is too short.")

    #Long username
    params = { username: "Valid Username", password: "a" * 129, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is too long.")
  end
   
  test "valid createUser password field" do
    #Valid username
    params = { username: "Valid Username", password: "a" * 128, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params).username, "Password is valid")
    params = { username: "Valid Username 2", password: "a" * 8, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username 2", Advertiser.createUser(params).username, "Password is valid")
  end

  test "invalid createUser email field" do
    #Blank email
    params = { username: "Valid Username", password: "Valid Password", email: "", company: "Some Company", usertype: 0 }
    assert_equal(-4, Advertiser.createUser(params), "Email is invalid")

    #Invalid email
    params = { username: "Valid Username", password: "Valid Password", email: "bobcnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-4, Advertiser.createUser(params), "Email is invalid")
  end

  test "valid createUser company field" do
     #Blank company is valid
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params).username, "Everything is valid")
  end

  test "valid loginUser and invalid loginUser username and password field" do
    #Valid username
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params).username, "Everything is valid")
    params = { username: "Valid Username", password: "Valid Password" }
    assert_equal("Valid Username", Advertiser.validateUser(params).username, "Everything is valid")

    #Invalid username
    params = { username: "Invalid Username", password: "Valid Password" }
    assert_equal(-1, Advertiser.validateUser(params), "Invalid username")

    #Invalid password
    params = { username: "Valid Username", password: "Invalid Password" }
    assert_equal(-1, Advertiser.validateUser(params), "Invalid password")
  end

  test "valid owner can add advertiser type" do
    params = { username: "User Name", password: "password", email: "asdf@asdf.com", company: "my comp", usertype: 1}
    Owner.createUser(params)
    assert_difference "Advertiser.count()", 1 do
      params[:usertype] = 2
      Advertiser.createUser(params)
    end
  end

  test "users of different type cannot choose same username" do
    params = { username: "User Name", password: "password", email: "asdf@asdf.com", company: "my comp", usertype: 1}
    Owner.createUser(params)
    assert_difference "Advertiser.count()", 0 do
      params[:usertype] = 0
      Advertiser.createUser(params)
    end
  end

  def favorite_setup(multiple) 
    params = { username: "User Name", password: "password", email: "asdf@asdf.com", company: "my comp", usertype: 0}
    @advertiser = Advertiser.createUser(params)
    owner = Owner.create(:username => "Username1234", :password => "password", :email => "email@crowdcast.com", :company => "hello5")
    params = {
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
      owner: owner,
      screen_resolution_x: 56,
      screen_resolution_y: 57,
      active: true,
      views: 0
    }  
    @listing = Listing.create(params)
    if multiple
      params[:title] = "Listing 2"
      @listing2 = Listing.create(params)
    end
  end


  test "advertiser can favorite listing" do
    favorite_setup false
    assert_difference "@advertiser.listings.size", 1 do
      success = @advertiser.favorite_listing @listing.id
      assert success == true
    end
  end

  test "advertiser can unfavorite listing" do
    favorite_setup false
    @advertiser.favorite_listing @listing.id
    assert_difference "@advertiser.listings.size", -1 do
      success = @advertiser.unfavorite_listing @listing.id
      assert success == true
    end
  end

  test "advertiser cant favorite nonexistant listing" do
    params = { username: "User Name", password: "password", email: "asdf@asdf.com", company: "my comp", usertype: 0}
    advertiser = Advertiser.createUser(params)
    assert_difference "advertiser.listings.size", 0 do
      success = advertiser.favorite_listing 99999 
      assert success == false
    end
  end

  test "advertiser can retrieve favorited listing" do
    favorite_setup false
    @advertiser.favorite_listing @listing.id
    listings = Advertiser.get_favorited_listings @advertiser.id
    assert_equal 1, listings.size 
    assert_equal @listing.id, listings.first.id
  end

  test "advertiser can retrieve multiple favorited listing" do
    favorite_setup true
    @advertiser.favorite_listing @listing.id
    @advertiser.favorite_listing @listing2.id
    listings = Advertiser.get_favorited_listings @advertiser.id
    assert_equal 2, listings.size 
    assert_equal @listing.id, listings.first.id
    assert_equal @listing2.id, listings.second.id
  end

end

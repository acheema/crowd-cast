require 'test_helper'

class AdvertiserTest < ActiveSupport::TestCase
  test "testing createUser username" do
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
    assert_equal("Valid Username", Advertiser.createUser(params), "Username should be 'Valid Username'")
    params = { username: "Valid Username", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-1, Advertiser.createUser(params), "Username already exists")

    #Already existing Owner username
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username 2", Owner.createUser(params), "Username should be 'Valid Username'")
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-1, Advertiser.createUser(params), "Username already exists")

    #Valid username
    params = { username: "a" * 6, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("a" * 6, Advertiser.createUser(params), "Username should be 6 'a's")
    params = { username: "a" * 128, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("a" * 128, Advertiser.createUser(params), "Username should be 128 'a's")
  end

  test "testing createUser password" do
    #Blank password
    params = { username: "Valid Username", password: "", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is blank.")

    #Short password
    params = { username: "Valid Username", password: "a" * 7, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is too short.")

    #Long username
    params = { username: "Valid Username", password: "a" * 129, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-3, Advertiser.createUser(params), "Password is too long.")

    #Valid username
    params = { username: "Valid Username", password: "a" * 128, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params), "Password is valid")
    params = { username: "Valid Username 2", password: "a" * 8, email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username 2", Advertiser.createUser(params), "Password is valid")
  end

  test "testing createUser email" do
    params = { username: "Valid Username", password: "Valid Password", email: "", company: "Some Company", usertype: 0 }
    assert_equal(-4, Advertiser.createUser(params), "Email is invalid")

    #Invalid username
    params = { username: "Valid Username", password: "Valid Password", email: "bobcnn.com", company: "Some Company", usertype: 0 }
    assert_equal(-4, Advertiser.createUser(params), "Email is invalid")
  end

  test "testing createUser company" do
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params), "Everything is valid")
  end

  test "testing loginUser" do
    #Valid username
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    assert_equal("Valid Username", Advertiser.createUser(params), "Everything is valid")
    params = { username: "Valid Username", password: "Valid Password" }
    assert_equal("Valid Username", Advertiser.validateUser(params), "Everything is valid")

    #Invalid username
    params = { username: "Invalid Username", password: "Valid Password" }
    assert_equal(-1, Advertiser.validateUser(params), "Invalid username")

    #Invalid password
    params = { username: "Valid Username", password: "Invalid Password" }
    assert_equal(-1, Advertiser.validateUser(params), "Invalid password")
  end
end

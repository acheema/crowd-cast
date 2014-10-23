require 'test_helper'

class OwnerTest < ActiveSupport::TestCase

  test "invalid createUser username field" do
    #Blank username
    params = { username: "", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-2, Owner.createUser(params), "Username is blank.")

    #Short username
    params = { username: "a", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-2, Owner.createUser(params), "Username is too short.")

    #Short username
    params = { username: "a" * 5, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-2, Owner.createUser(params), "Username is too short.")

    #Long username
    params = { username: "a" * 129, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-2, Owner.createUser(params), "Username is too long.")

    #Already existing Owner username
    params = { username: "Valid Username", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("Valid Username", Owner.createUser(params), "Username should be 'Valid Username'")
    params = { username: "Valid Username", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-1, Owner.createUser(params), "Username already exists")

    #Already existing Advertiser username
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("Valid Username 2", Advertiser.createUser(params), "Username should be 'Valid Username'")
    params = { username: "Valid Username 2", password: "validpassword", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-1, Owner.createUser(params), "Username already exists")
  end

  test "valid createUser username field" do
    #Valid username
    params = { username: "a" * 6, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("a" * 6, Owner.createUser(params), "Username should be 6 'a's")
    params = { username: "a" * 128, password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("a" * 128, Owner.createUser(params), "Username should be 128 'a's")
  end

  test "invalid createUser password field" do
    #Blank password
    params = { username: "Valid Username", password: "", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-3, Owner.createUser(params), "Password is blank.")

    #Short password
    params = { username: "Valid Username", password: "a" * 7, email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-3, Owner.createUser(params), "Password is too short.")

    #Long username
    params = { username: "Valid Username", password: "a" * 129, email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-3, Owner.createUser(params), "Password is too long.")
  end
   
  test "valid createUser password field" do
    #Valid username
    params = { username: "Valid Username", password: "a" * 128, email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("Valid Username", Owner.createUser(params), "Password is valid")
    params = { username: "Valid Username 2", password: "a" * 8, email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("Valid Username 2", Owner.createUser(params), "Password is valid")
  end

  test "invalid createUser email field" do
    #Blank email
    params = { username: "Valid Username", password: "Valid Password", email: "", company: "Some Company", usertype: 1 }
    assert_equal(-4, Owner.createUser(params), "Email is invalid")

    #Invalid email
    params = { username: "Valid Username", password: "Valid Password", email: "bobcnn.com", company: "Some Company", usertype: 1 }
    assert_equal(-4, Owner.createUser(params), "Email is invalid")
  end

  test "valid createUser company field" do
     #Blank company is valid
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "", usertype: 1 }
    assert_equal("Valid Username", Owner.createUser(params), "Everything is valid")
  end

  test "valid loginUser and invalid loginUser username and password field" do
    #Valid username
    params = { username: "Valid Username", password: "Valid Password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    assert_equal("Valid Username", Owner.createUser(params), "Everything is valid")
    params = { username: "Valid Username", password: "Valid Password" }
    assert_equal("Valid Username", Owner.validateUser(params), "Everything is valid")

    #Invalid username
    params = { username: "Invalid Username", password: "Valid Password" }
    assert_equal(-1, Owner.validateUser(params), "Invalid username")

    #Invalid password
    params = { username: "Valid Username", password: "Invalid Password" }
    assert_equal(-1, Owner.validateUser(params), "Invalid password")
  end
end

#written by Jason Clark, Jessica Wong
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "button[data-target=?]", "#login-modal"
    assert_select "button[data-target=?]", "#signup-modal"
  end

  test "listings page" do
    get new_listing_path
    assert_template 'listings/new'
    assert_select "form[class=?]", "form-horizontal col-lg-8 col-lg-offset-2"
  end

  test "search page layout by going to /search" do
    get search_path
    assert_template 'listings/search'
  end

  test "advertiser dashboard layout" do
    post '/api/create_user',  { user: { username: "JohnDoe1", \
                     password: "password1", \
                     email: "asdf@asdf.com", \
                     company: 'my comp', \
                              usertype: '0' }}
    assert_response :success

    get advertiser_dashboard_path
    assert_template 'advertisers/advertiser_dashboard'
  end

test "owner dashboard layout" do
  post '/api/create_user',  { user: { username: "JohnDoe1", \
                   password: "password1", \
                   email: "asdf@asdf.com", \
                   company: 'my comp', \
                            usertype: '1' }}
  assert_response :success

  get owner_dashboard_path
  assert_template 'owners/owner_dashboard'
  end


  #written by Jason Clark, Jessica Wong
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path
    assert_select "button[data-target=?]", "#login-modal"
    assert_select "button[data-target=?]", "#signup-modal"
  end

  test "listings page" do
    get new_listing_path
    assert_template 'listings/new'
    assert_select "form[class=?]", "form-horizontal col-lg-8 col-lg-offset-2"
  end

  test "search page layout by going to /search" do
    get search_path
    assert_template 'listings/search'
  end

  test "advertiser dashboard layout" do
    post '/api/create_user',  { user: { username: "JohnDoe1", \
                     password: "password1", \
                     email: "asdf@asdf.com", \
                     company: 'my comp', \
                              usertype: '0' }}
    assert_response :success

    get advertiser_dashboard_path
    assert_template 'advertisers/advertiser_dashboard'
  end

test "owner dashboard layout" do
  post '/api/create_user',  { user: { username: "JohnDoe1", \
                   password: "password1", \
                   email: "asdf@asdf.com", \
                   company: 'my comp', \
                            usertype: '1' }}
  assert_response :success

  get owner_dashboard_path
  assert_template 'owners/owner_dashboard'
  end



  test "switch between owner and advertiser with user type 2" do
  post '/api/create_user',  { user: { username: "JohnDoe2", \
                   password: "password1", \
                   email: "asdf@asdf.com", \
                   company: 'my comp', \
                            usertype: '0' }}
    assert_difference "Owner.count()", 1 do
      post '/api/create_user', {user: { usertype: '2' }}, \
                       { "HTTP_COOKIE" => "usertype=0; username=JohnDoe2;" }

    get owner_dashboard_path
    assert_template 'owners/owner_dashboard'

    get advertiser_dashboard_path
    assert_template 'advertisers/advertiser_dashboard'
    assert_select "button[data-toggle=?]", "dropdown"
    end
  end


end

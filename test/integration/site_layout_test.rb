#written by Jason Clark
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
end

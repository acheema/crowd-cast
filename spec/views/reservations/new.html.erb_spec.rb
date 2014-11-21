require 'rails_helper'

RSpec.describe "reservations/new", :type => :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      :listing => nil,
      :advertiser => nil,
      :advertisement => nil,
      :start_date => "MyString",
      :end_date => "MyString",
      :price => "9.99"
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "input#reservation_listing_id[name=?]", "reservation[listing_id]"

      assert_select "input#reservation_advertiser_id[name=?]", "reservation[advertiser_id]"

      assert_select "input#reservation_advertisement_id[name=?]", "reservation[advertisement_id]"

      assert_select "input#reservation_start_date[name=?]", "reservation[start_date]"

      assert_select "input#reservation_end_date[name=?]", "reservation[end_date]"

      assert_select "input#reservation_price[name=?]", "reservation[price]"
    end
  end
end

require 'rails_helper'

RSpec.describe "reservations/edit", :type => :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :listing => nil,
      :advertiser => nil,
      :advertisement => nil,
      :start_date => "MyString",
      :end_date => "MyString",
      :price => "9.99"
    ))
  end

  it "renders the edit reservation form" do
    render

    assert_select "form[action=?][method=?]", reservation_path(@reservation), "post" do

      assert_select "input#reservation_listing_id[name=?]", "reservation[listing_id]"

      assert_select "input#reservation_advertiser_id[name=?]", "reservation[advertiser_id]"

      assert_select "input#reservation_advertisement_id[name=?]", "reservation[advertisement_id]"

      assert_select "input#reservation_start_date[name=?]", "reservation[start_date]"

      assert_select "input#reservation_end_date[name=?]", "reservation[end_date]"

      assert_select "input#reservation_price[name=?]", "reservation[price]"
    end
  end
end

require 'rails_helper'

RSpec.describe "reservations/index", :type => :view do
  before(:each) do
    assign(:reservations, [
      Reservation.create!(
        :listing => nil,
        :advertiser => nil,
        :advertisement => nil,
        :start_date => "Start Date",
        :end_date => "End Date",
        :price => "9.99"
      ),
      Reservation.create!(
        :listing => nil,
        :advertiser => nil,
        :advertisement => nil,
        :start_date => "Start Date",
        :end_date => "End Date",
        :price => "9.99"
      )
    ])
  end

  it "renders a list of reservations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Start Date".to_s, :count => 2
    assert_select "tr>td", :text => "End Date".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end

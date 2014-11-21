require 'rails_helper'

RSpec.describe "reservations/show", :type => :view do
  before(:each) do
    @reservation = assign(:reservation, Reservation.create!(
      :listing => nil,
      :advertiser => nil,
      :advertisement => nil,
      :start_date => "Start Date",
      :end_date => "End Date",
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Start Date/)
    expect(rendered).to match(/End Date/)
    expect(rendered).to match(/9.99/)
  end
end

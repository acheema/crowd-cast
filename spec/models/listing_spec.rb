require 'spec_helper'

describe "Listing model" do
  it "should be successful" do
	  @listing = instance_double("Listing", :owner_id => 1)
	  expect(Listing).to receive(:getOwnerListings).and_return(@listing)
	  Listing.getOwnerListings(1)
  end
end
#written by Jason Clark
require 'spec_helper'

describe "Listing model" do
  it "getOwnerListings should be successful" do
	  @listing = double("listing")
	  expect(Listing).to receive(:getOwnerListings).and_return(@listing)
	  Listing.getOwnerListings(1)
  end

  it "getListingDetails should be successful" do
  	@listing = double("listing")
  	expect(Listing).to receive(:find).and_return(@listing)
  	expect(@listing).to receive(:views) { 1 }
  	expect(@listing).to receive(:update_attributes).with(:views => 2)
  	Listing.getListingDetails 1
  end

end
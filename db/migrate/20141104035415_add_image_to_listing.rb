class AddImageToListing < ActiveRecord::Migration
  def change
  	add_attachment :listings, :image
  end
end

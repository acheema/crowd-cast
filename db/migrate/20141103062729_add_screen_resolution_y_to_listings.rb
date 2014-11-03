class AddScreenResolutionYToListings < ActiveRecord::Migration
  def change
    add_column :listings, :screen_resolution_y, :integer
  end
end

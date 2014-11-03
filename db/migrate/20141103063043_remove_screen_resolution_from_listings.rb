class RemoveScreenResolutionFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :screen_resolution, :integer
  end
end

class AddScreenResolutionXToListings < ActiveRecord::Migration
  def change
    add_column :listings, :screen_resolution_x, :integer
  end
end

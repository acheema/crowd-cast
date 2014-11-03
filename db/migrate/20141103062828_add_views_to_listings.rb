class AddViewsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :views, :integer
  end
end

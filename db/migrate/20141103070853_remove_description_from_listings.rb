class RemoveDescriptionFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :description, :boolean
  end
end

class RemoveCostPerWeekFromListings < ActiveRecord::Migration
  def change
    remove_column :listings, :cost_per_week, :float
  end
end

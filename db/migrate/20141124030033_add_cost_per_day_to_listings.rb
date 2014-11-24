class AddCostPerDayToListings < ActiveRecord::Migration
  def change
    add_column :listings, :cost_per_day, :float
  end
end

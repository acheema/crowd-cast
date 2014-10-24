class AddDescripandChangeClicksPerWeek < ActiveRecord::Migration
  def change
  	change_table :listings do |t|
      t.rename :clicks_per_week, :views_per_week
    end
    add_column(:listings, :description, :text)
  end
end

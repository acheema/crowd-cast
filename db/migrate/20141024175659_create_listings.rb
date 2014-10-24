class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.float :height
      t.float :width
      t.integer :time_per_click
      t.integer :views_per_week
      t.float :cost_per_week
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.integer :screen_resolution
      t.references :owner, index: true

      t.timestamps
    end
  end
end

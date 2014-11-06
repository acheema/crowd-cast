class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.string :description
      t.integer :screen_resolution_x
      t.integer :screen_resolution_y
      t.references :advertiser, index: true
      t.string :advertisement_url

      t.timestamps
    end
  end
end

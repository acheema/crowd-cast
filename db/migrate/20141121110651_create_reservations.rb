class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :listing, index: true
      t.references :advertiser, index: true
      t.references :advertisement, index: true
      t.string :start_date
      t.string :end_date
      t.decimal :price

      t.timestamps
    end
  end
end

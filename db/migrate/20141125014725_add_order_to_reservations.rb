class AddOrderToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :order, :string
  end
end

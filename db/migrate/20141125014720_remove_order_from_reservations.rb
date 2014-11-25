class RemoveOrderFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :order, :integer
  end
end

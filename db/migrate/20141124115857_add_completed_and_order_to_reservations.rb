class AddCompletedAndOrderToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :completed, :boolean
    add_column :reservations, :order, :integer
  end
end

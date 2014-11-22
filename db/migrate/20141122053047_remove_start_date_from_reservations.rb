class RemoveStartDateFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :start_date, :datetime
  end
end

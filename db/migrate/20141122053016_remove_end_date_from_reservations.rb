class RemoveEndDateFromReservations < ActiveRecord::Migration
  def change
    remove_column :reservations, :end_date, :datetime
  end
end

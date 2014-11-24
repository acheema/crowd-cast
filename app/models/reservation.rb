class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :advertiser
  belongs_to :advertisement
  
  validates :listing, :presence => true
  validates :advertiser, :presence => true
  validates :advertisement, :presence => true
  validates :start_date, presence: true
  validates_format_of :start_date, :with => /\A\d{4}-\d{2}-\d{2}\z/
  validates :end_date, presence: true
  validates_format_of :end_date, :with => /\A\d{4}-\d{2}-\d{2}\z/
  validate :dateValidation
  validates :price, presence: true, numericality: true
  validates :completed, inclusion: { in: [true, false] }
  validates :order, :presence => true   
 
   def self.get(params)
      if (/\A\d{4}-\d{2}-\d{2}\z/.match(params[:start_date]) and /\A\d{4}-\d{2}-\d{2}\z/.match(params[:end_date])) 
         self.reservationsInRange(params[:listing], params[:start_date], params[:end_date])
      end
   end

   def dateValidation
      if (start_date > end_date)
         errors.add(:date, "start_date can't be greater than end_date")
      else
         if not (errors[:start_date].any? or errors[:end_date].any?)
            reservations = Reservation.reservationsInRange(listing, start_date, end_date)
            dates = {}
            reservation_dates = Hash.new(0)
            #make sure none of these dates have more than 8 reservations
            reservations.each do |reservation|
               current_date = [ start_date, reservation.start_date ].max
               last_date = [ end_date, reservation.end_date ].min
               while current_date < last_date do
                  reservation_dates[current_date.to_formatted_s(:iso8601)] += 1
                  current_date = current_date.tomorrow()
               end
            end
            reservation_dates.delete_if { |date, number| number < 8 }
            if reservation_dates.any?
               errors.add(:full_dates, reservation_dates.keys)
            end
         end
      end
   end
   
   def self.reservationsInRange(listing, start_date, end_date)
      if not (start_date > end_date)
         query = "listing_id = #{listing.id} and "
         query += "(('#{start_date}' between start_date and end_date) "
         query += "or ('#{end_date}' between start_date and end_date)"
         query += "or ('#{start_date}' <= start_date and '#{end_date}' >= end_date))"
         Reservation.where(query)
      end
   end

   def self.completePayment(order)
      Reservation.where(:order => order).update_all(:completed => true)
   end

   def self.deleteOrder(order)
      Reservation.where(:order => order).destroy_all
   end
  
   # Clear out the table
  def self.TESTAPI_resetFixture
    Reservation.delete_all
  end
end

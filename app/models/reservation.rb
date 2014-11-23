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
   
   def self.create(params)
      reservation = Reservation.new(params)
      if reservation.save
         return true
      else
         errors = reservation.errors
         if errors.any?
            return false
         end
      end
   end 

   def self.get(params)
      self.reservationsInRange(params[:listing], params[:start_date], params[:end_date])
   end

   def dateValidation
      puts listing_id
      if (start_date > end_date)
         errors.add(:date, "start_date can't be greater than end_date")
      else
         reservations = Reservation.reservationsInRange(listing, start_date, end_date)
         dates = {}
         reservations.each do |reservation|
            puts reservation 
         end
         if false
            errors.add(:fuck, "some error")
         end
      end
   end
   
   def self.reservationsInRange(listing, start_date, end_date)
      if not (start_date > end_date)
         query = "listing_id = #{listing.id} and "
         query += "(('#{start_date}' between start_date and end_date) "
         query += "or ('#{end_date}' between start_date and end_date)"
         query += "or ('#{start_date}' <= start_date and '#{end_date}' >=  end_date))"
         Reservation.where(query)
      end
   end
end

class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :advertiser
  belongs_to :advertisement
  
  validates :listing, :presence => true
  validates :advertiser, :presence => true
  validates :advertisement, :presence => true
  validates :start_date, presence: true, :start_date_validation
  validates_format_of :start_date, :with => /\A\d{4}-\d{2}-\d{2}\z/
  validates :end_date, presence: true, :end_date_validation
  validates_format_of :end_date, :with => /\A\d{4}-\d{2}-\d{2}\z/
  validates :price, presence: true, numericality: true

   def end_date_validation
   end

   def start_date_validation
   end

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

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
  validate :date_validation
  validates :price, presence: true, numericality: true

   def date_validation
      query = "start_date <= '#{start_date}' and end_date >= '#{start_date}' "
      query += "or start_date >= '#{start_date}' and end_date <= '#{end_date}' "
      query += "or start_date >= '#{end_date}' and end_date >= '#{end_date}' "
      query += "or start_date <= '#{start_date}' and end_date >= '#{end_date}'"
      reservations = Reservation.where(query)
      dates = {}
      reservations.each do |reservation|
         puts reservation 
      end
      if false
         errors.add(:fuck, "some error")
      end
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

end

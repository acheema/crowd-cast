class Listing < ActiveRecord::Base
   belongs_to :owner
  
   geocoded_by :address
   after_validation :geocode
      
   validates :title, presence: true, length: { maximum: 128, minimum: 4 }
   validates :height, presence: true, numericality: { only_integer: true }
   validates :width, presence: true, numericality: { only_integer: true }
   validates :time_per_click, presence: true, numericality: { only_integer: true }
   validates :clicks_per_week, presence: true, numericality: { only_integer: true }
   validates :cost_per_week, presence: true, numericality: true
   validates :street, presence: true, if: :gpsSet?
   validates :city, presence: true, if: :gpsSet?
   validates :state, presence: true, if: :gpsSet?
   validates :zip, presence: true, if: :gpsSet?
   validates :owner, :presence => true 
   
   def address
      [street, city, state].compact.join(', ')
   end

   def gpsSet?
      if :latitude == nil or :longitude == nil
         return true
      else
         return false
      end
   end
  
   def self.createListing(params)
      listing = Listing.new(params)
      if listing.save
         return listing.id
      else
         errors = listing.errors
         return -1 if errors[:title].any?
         return -2 if errors[:height].any?
         return -3 if errors[:width].any?
         return -4 if errors[:time_per_click].any?
         return -5 if errors[:clicks_per_week].any?
         return -6 if errors[:cost_per_week].any?
         return -7 if errors[:street].any?
         return -8 if errors[:city].any?
         return -9 if errors[:state].any?
         return -10 if errors[:zip].any?
         return -11 if errors[:owner].any?
         #Shouldn't reach here
         errors.each do |key, value|
            puts "#{key}:#{value}"
         end
      end
   end

   def self.getListings(city)
      listings = Listing.where("city = '#{city}'")
      listings
      array = []
      listings.each do |listing|
         array << { "listing_id" => listing.id, "title" => listing.title }
      end
      return array
   end 

   def self.getListingDetails(id)
      listing = Listing.find(id)
      
      return listing
   end
end

#Written by Jason, Sukriti, Jhoong

class Listing < ActiveRecord::Base
  has_and_belongs_to_many :advertisements
  belongs_to :owner
  has_many :messages

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.city    = geo.city
    end
  end
  after_validation :reverse_geocode, :if => [:latitude?, :longitude?]
  geocoded_by :address
  after_validation :geocode, :if => [:street?, :city?, :state?, :zip?]

  validates :title, presence: true, length: { maximum: 128, minimum: 4 }
  validates :height, presence: true, numericality: true
  validates :width, presence: true, numericality: true
  validates :time_per_click, presence: true, numericality: { only_integer: true }
  validates :views_per_week, presence: true, numericality: { only_integer: true }
  validates :cost_per_week, presence: true, numericality: true
  validates :street, presence: true, :unless => [ :latitude?, :longitude? ]
  validates :city, presence: true, :unless => [:latitude?, :longitude?]
  validates :state, presence: true, :unless => [:latitude?, :longitude?]
  validates :zip, presence: true, :unless => [:latitude?, :longitude?]
  validates :owner, :presence => true
  validates :screen_resolution_x, presence: true, numericality: {only_integer: true}
  validates :screen_resolution_y, presence: true, numericality: {only_integer: true}
  validates :active, presence: true, :inclusion => {:in => [true, false]}
  validates :views, presence: true, numericality: {only_integer: true}
  #Image validation

  has_attached_file :image, :storage => :s3, :bucket => ENV['AWS_BUCKET'], styles: {
  thumb: '100x100>',
  square: '200x200#',
  medium: '300x300>'
  }, :default_url => "default.png"
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

   def address
      [street, city, state].compact.join(', ')
   end

   def activate(id)
      listing = Listing.find(id)
      listing.update_attributes(:active => true)
      return listing
   end

   def deactivate(id)
      listing = Listing.find(id)
      listing.update_attributes(:active => false)
      return listing
   end

   def self.createListing(params)
      listing = Listing.new(params.merge(:views => 0, :active => true))
      if listing.save
         return listing.id
      else
         errors = listing.errors
         return -1 if errors[:title].any?
         return -2 if errors[:height].any?
         return -3 if errors[:width].any?
         return -4 if errors[:time_per_click].any?
         return -5 if errors[:views_per_week].any?
         return -6 if errors[:cost_per_week].any?
         return -7 if errors[:street].any?
         return -8 if errors[:city].any?
         return -9 if errors[:state].any?
         return -10 if errors[:zip].any?
         return -11 if errors[:owner].any?
         return -12 if errors[:screen_resolution_x].any?
         return -13 if errors[:screen_resolution_y].any?
         #Shouldn't reach here
         errors.each do |key, value|
            puts "#{key}:#{value}"
         end
      end
   end
   
   def self.getListings(city)
      listings = Listing.where("city = '#{city}'")
      return listings
   end

   def self.getListingDetails(id)
      listing = Listing.find(id)
      views = listing.views + 1
      listing.update_attributes(:views => views)
      return listing
   end

  def self.getOwnerListings(ownerid)
    listings = Listing.where("owner_id = '#{ownerid}'")
    return listings
  end

  # Clear out the table
  def self.TESTAPI_resetFixture
    Listing.delete_all
  end
end

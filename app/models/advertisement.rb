# Written by Jhoong
class Advertisement < ActiveRecord::Base
  belongs_to :advertiser
  validates :title, presence: true, length: { maximum: 128, minimum: 4 }
  validates :advertiser, :presence => true
  validates :height, presence: true, numericality: {only_integer: true}
  validates :width, presence: true, numericality: {only_integer: true}

   has_attached_file :ad, :storage => :s3, :bucket => ENV['AWS_BUCKET'], styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }, :default_url => "default.png"
  validates_attachment_content_type :ad, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  
   def self.createAd(params)
      ad = Advertisement.new(params)
      if ad.save
         return ad.id
      else
         errors = ad.errors
         return -1 if errors[:title].any?
         return -2 if errors[:height].any?
         return -3 if errors[:width].any?
         return -4 if errors[:advertiser].any?
      end 
   end 
   
   def self.getAds(advertiser_id)
      ads = Advertisement.where("advertiser_id = '#{advertiser_id}'")
      return ads
   end 

  # Clear out the table
  def self.TESTAPI_resetFixture
    Advertisement.delete_all
  end
end

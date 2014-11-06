# Written by Jhoong
class Advertisement < ActiveRecord::Base
  belongs_to :advertiser
   validates :advertisement_url, presence: true
   validates :title, presence: true
   validates :advertiser, :presence => true
   validates :screen_resolution_x, presence: true, numericality: {only_integer: true}
   validates :screen_resolution_y, presence: true, numericality: {only_integer: true}
  
   def self.createAd(params)
      ad = Advertisement.new(params)
      if ad.save
         return ad.id
      else
         errors = ad.errors
         return -1 if errors[:title].any?
         return -2 if errors[:advertisement_url].any?
         return -3 if errors[:screen_resolution_x].any?
         return -4 if errors[:screen_resolution_y].any?
         return -5 if errors[:advertiser_id].any?
      end 
   end 
   
   def self.getAds(advertiser_id)
      ads = Advertisement.where("advertiser_id = '#{advertiser_id}'")
      return ads
   end 

end

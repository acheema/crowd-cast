# Written by Jhoong
class AdvertisementsController < ApplicationController

   # create an ad, the user must be an advertiser
   def createAd
      username = cookies[:username]
      if (@advertiser = Advertiser.find_by_username(username))
         status = Advertisement.createAd(create_ad_params.merge(:advertiser_id => @advertiser.id))
         render :json => { status: status }
      else
         # In case the cookie is not set. Ideally, this shouldn't be possible
         render :json => { status: -4 }
      end 
   end

   # get the ads of this user
   def getAds
      username = cookies[:username]
      if (@advertiser = Advertiser.find_by_username(username))
         @ads = Advertisment.getAds(@advertiser.id)
      end
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_ad_params
       params.require(:advertisement).permit(:title, :description, :width, :height, :ad)
    end
end

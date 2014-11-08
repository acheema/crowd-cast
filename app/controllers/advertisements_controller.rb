# Written by Jhoong
class AdvertisementsController < ApplicationController

   # create an ad, the user must be an advertiser
   def createAd
      username = cookies[:username]
      advertiser = Advertiser.find_by_username(username)
      status = Advertisement.createAd(create_ad_params.merge(:advertiser => advertiser))
      if create_ad_params.has_key? (:ad)
         if status > 0
            redirect_to "/advertiser_dashboard"
         else
            @advertisement = Advertisement.new
            @advertisementStatus = status
            render :new
         end
      else
         render :json => { status: status }
      end 
   end

  def new
    @advertisement = Advertisement.new
  end

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

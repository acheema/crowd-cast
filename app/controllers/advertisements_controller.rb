# Written by Jhoong
class AdvertisementsController < ApplicationController

   def createAd
      username = cookies[:username]
      advertiser_id = Advertiser.find_by_username(username).id
      status = Advertisement.createAd(create_ad_params.merge(:advertiser_id => advertiser_id))
      render :json => { status: status }
   end
   
   def getAds
      username = cookies[:username]
      advertisement_id = Advertiser.find_by_username(username).id
      @ads = Advertisment.getAds(advertisement_id)
   end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_ad_params
      params.require(:advertisement).permit(:title, :description, :screen_resolution_x, :screen_resolution_y, :advertisement_url)
    end
end

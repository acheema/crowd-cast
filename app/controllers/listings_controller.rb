# Written by Jhoong, Sukriti, Jason
class ListingsController < ApplicationController

  def createListing
    username = cookies[:username]
    owner_id = Owner.find_by_username(username).id
    response = Listing.createListing(create_listing_params.merge(:owner_id => owner_id))
    #render :action => 'show'
    render :json => { status: response }
  end

  def getListings
    listings = Listing.getListings(listings_params[:city])
    render :json => { status: 1, listings: listings }
   end

  def search
    @city = params[:city]
    if @city then
      @listings = Listing.getListings(@city)
    end
    @markers = Gmaps4rails.build_markers(@listings) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow render_to_string(:partial => "/listings/infowindow", :locals => { :location => location})
      marker.json({:id => location.id})
    end
  end

  def show
    @listing = Listing.getListingDetails(params[:listing_id])
    @owner_username = Owner.find(@listing.owner_id).username
  end

  def activate
    Listing.activate( activate_params[:id] )
    render :json => { status: 1 }
  end

  def deactivate
    Listing.deactivate( activate_params[:id] )
    render :json => { status: 1 }
  end

   # Clean out the tables
    def resetFixture
        Listing.TESTAPI_resetFixture
        render :json => { status: 1 }
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def activate_params
      params.require(:listing).permit(:id)
    end

    def listing_details_params
       #params.require(:listing).permit(:id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listings_params
      params.require(:listing).permit(:city)
    end

    def create_listing_params
      params.require(:listing).permit(:title, :height, :width, :screen_resolution_x, :screen_resolution_y, :time_per_click, :views_per_week, :cost_per_week, :street, :city, :state, :zip, :latitude, :longitude, :description, :image)
    end

end

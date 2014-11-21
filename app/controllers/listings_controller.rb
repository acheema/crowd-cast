# Written by Jhoong, Sukriti, Jason
class ListingsController < ApplicationController

  def createListing
    username = cookies[:username]
    owner = Owner.find_by_username(username)
    status = Listing.createListing(create_listing_params.merge(:owner => owner))
    if (create_listing_params.has_key? (:image)) 
      if status > 0
         params = { :listing_id => status }
         redirect_to "/listings/show?#{params.to_query}"
      else
         @listing = Listing.new
         @listingStatus = status
         render :new
      end
   else
      render :json => { status: status }
   end
  end

  def new
    @listing = Listing.new
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
    @markers = Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
      marker.infowindow render_to_string(:partial => "/listings/infowindow", :locals => { :listing => listing })
      marker.json({:id => listing.id})
    end
  end

  def show
    @listing = Listing.getListingDetails(params[:listing_id])
    @owner_username = Owner.find(@listing.owner_id).username
    if Advertiser.listing_favorited @listing.id, cookies[:username]
      @listing_favorited = true
    else 
      @listing_favorited = false
    end
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

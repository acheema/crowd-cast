class ListingsController < ApplicationController

  def createListing 
    username = cookies.signed[:username]
    owner_id = Owner.find_by_username(username).id
    response = Listing.createListing(create_listing_params.merge(:owner_id => owner_id))
    render :json => { status: response }
  end 

  def getListings
    listings = Listing.getListings(listings_params[:city])
    render :json => { status: 1, listings: listings }    
   end 

  def search
    # @city = params[:city]
    # if @city then
    #   @listings = Listing.getListings(@city) 
    # end
    @city = params[:city]
    if @city then
      @listings = Listing.getListings(@city)
    end   
  end

  def getListingDetails
    response = Listing.getListingDetails(listing_details_params[:id])
    render :json => { status: 1, listing: response }
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end
   
    def listing_details_params
       params.require(:listing).permit(:id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listings_params 
      params.require(:listing).permit(:city)
    end

    def create_listing_params
      params.require(:listing).permit(:title, :height, :width, :time_per_click, :views_per_week, :cost_per_week, :street, :city, :state, :zip, :latitude, :longitude)
    end
end

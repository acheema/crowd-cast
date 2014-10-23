class ListingsController < ApplicationController
  # Code Written By : Sukriti Singal
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  def create_listing 
    response = listing.create_listing(listing_params)
    
    case response[0] 

    when Listing::ERR_INVALID_TITLE 
      @message = "Please add a title" 

    when Listing::ERR_INVALID_HEIGHT
      @message = "Please add a height" 

    when Listing::ERR_INVALID_WIDTH
      @message = "Please add a width" 

    when Listing::ERR_INVALID_TIME_CLICK
      @message = "Please add a time per click" 

    when Listing::ERR_INVALID_CLICK_WEEK
      @message = "Please add a click per week" 

    when Listing::ERR_INVALID_COST_WEEK
      @message = "Please add a cost per week" 

    when Listing::ERR_INVALID_STREET
      @message = "Please add a street" 

    when Listing::ERR_INVALID_CITY
      @message = "Please add a city" 

    when Listing::ERR_INVALID_STATE
      @message = "Please add a state" 

    when Listing::ERR_INVALID_ZIP
      @message = "Please add a zip" 

    when Listing::ERR_INVALID_LATITUDE
      @message = "Please add a latitude" 

    when Listing::ERR_INVALID_LONGITUDE
      @message = "Please add a longitude" 

    when Listing::ERR_SAVE_FAILURE
      @message= "Adding Listing Failed. Please try again"

    when Listing::SUCCESS
      @listing = response[1]
      respond_to do |format|
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      end
    end

    if response[0] != Listing::SUCCESS && response[0] != Listing::ERR_SAVE_FAILURE
      respond_to do |format|
        format.html {render action: 'mainpage'}
        format.json {render :json => {errCode: response[0]}, status: 200}
      end
    end 
      
  end 

  def getListings
    listing.getListings(city)
  end 

  def getListingDetails

    response = listing.getListingDetails(listing_details_params[:id])

    if response[0] == $SUCCESS 
      @listing = response[1]
      respond_to do |format|
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      end
    else
      @message = "Listing does not exist"
      respond_to do |format|
        format.html {render action: 'mainpage'}
        format.json {render :json => {errCode: response[0]}, status: 200}
      end
    end 
  end 

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_details_params 
      params.require(:listing).permits(:id)
    end

    def listing_params
      params.require(:listing).permit(:title, :height, :width, :time_per_click, :clicks_per_week, :cost_per_week, :street, :city, :state, :zip, :latitude, :longitude)
    end
end

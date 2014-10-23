class Listing < ActiveRecord::Base
	# Code Written By : Sukriti Singal
	$SUCCESS = 1
	$ERR_INVALID_TITLE = -1 
	$ERR_INVALID_HEIGHT = -2
	$ERR_INVALID_WIDTH = -3
	$ERR_INVALID_TIME_CLICK = -4 
	$ERR_INVALID_CLICK_WEEK = -5 
	$ERR_INVALID_COST_WEEK = -6
	$ERR_INVALID_STREET = -7
	$ERR_INVALID_CITY = -8 
	$ERR_INVALID_STATE = -9 
	$ERR_INVALID_ZIP = -10	
	$ERR_INVALID_LATITUDE = -11 
	$ERR_INVALID_LONGITUDE = -12 
	$ERR_SAVE_FAILURE = -13
	$ERR_LISTING_NOT_EXIST = -14
    
    def self.create_listing(listing_params) 

  	  	if listing_params[:title].length < 1 
  			response[0] = $ERR_INVALID_TITLE

	    elsif listing_params[:height] <= 0
	  		response[0] = $ERR_INVALID_HEIGHT

	  	elsif listing_params[:width].length <= 0
	  		response[0] = $ERR_INVALID_WIDTH

	  	elsif listing_params[:time_per_click] <= 0 
	  		response[0] = $ERR_INVALID_TIME_CLICK 

	  	elsif listing_params[:clicks_per_week] <= 0
	  		response[0] = $ERR_INVALID_CLICK_WEEK

	  	elsif listing_params[:cost_per_week] <= 0
	  		respose[0] = $ERR_INVALID_COST_WEEK

	  	elsif listing_params[:street].length < 1 
	  		response[0] = $ERR_INVALID_STREET

	  	elsif listing_params[:city].length < 1 
	  		response[0] = $ERR_INVALID_CITY

	  	elsif listing_params[:state].length < 1 
	  		response[0] = $ERR_INVALID_STATE

	  	elsif listing_params[:zip].length < 1 
	  		response[0] = $ERR_INVALID_ZIP

	  	elsif listing_params[:latitude].length < 1 
	  		response[0] = $ERR_INVALID_LATITUDE

	  	elsif listing_params[:longitude].length < 1
	  		response[0] = $ERR_INVALID_LONGITUDE

	  	else 
	  		listing = Listing.new(listing_params)
	  		booleanSaved = listing.save
	  		if booleanSaved 
	  			response[0] = $SUCCESS
	  			response[1] = listing.id
	  		else 
	  			response[0] = $ERR_SAVE_FAILURE
	  		end 
	  	end 

	  	return response
    end

    def self.getListings(city) 
    	listing = Listing.where("city = ?", city)
    	return listing
    end

    def self.getListingDetails(listing_id) 
    	listing = Listing.find(listing_id)
    	if listing 
    		response[0] = $SUCCESS
    		response[1] = listing
    	else 
    		response[0] = $ERR_LISTING_NOT_EXIST
    	end
    	return response
    end
end

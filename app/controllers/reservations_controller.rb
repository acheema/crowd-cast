require 'digest/sha1'

class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  wrap_parameters :reservation, include: [:advertisement_id, :listing_id, :dates, :start_date, :end_date, :price]

  # GET /reservations/new
  def new
    @listing = Listing.find(params[:listing_id])
    @reservation = Reservation.new
    username = cookies[:username]
    if (advertiser = Advertiser.find_by_username(username))
      @ads = Advertisement.getAds(advertiser.id)
    end
  end

  def get
    reservation_params = get_reservations_params
    listing = Listing.find(reservation_params[:listing_id])
    reservation_params.delete("listing_id")
    reservation_params.merge!(:listing => listing)
    reservations = Reservation.get(reservation_params)
    if reservations and reservations.any?
      reservation_dates = []
      reservations.each do |reservation|
         reservation_dates.push({ start: reservation.start_date, end: reservation.end_date})
      end
      render :json => reservation_dates
    else
      render :json => { status: -1 }
    end
  end

  # POST /reservations
  # POST /reservations.json
  def create
    reservation_params = create_reservations_params

    # lets verify these entries actually exist
    username = cookies[:username]
    advertiser = Advertiser.find_by_username(username)
    listing = Listing.find(reservation_params[:listing_id])
    advertisement = Advertisement.find(reservation_params[:advertisement_id])
    reservation_params.delete("listing_id")
    reservation_params.delete("advertisement_id")
    reservation_params.merge!(:advertiser => advertiser, :listing => listing, :advertisement => advertisement)
    order = Digest::SHA1.hexdigest "" + advertiser.id.to_s + reservation_params[:dates].to_s + Time.new.to_s 
    
    # For each reservation, create
    dates = reservation_params[:dates]
    reservation_params.delete("dates")
    dates.each do |reservation|
       reservation = Reservation.new(reservation_params.merge(:start_date => reservation[:start_date],  
                                                              :end_date => reservation[:end_date], 
                                                              :price => reservation[:price],
                                                              :completed => false,
                                                              :order => order ))
       if not reservation.save
          errors = reservation.errors
          if errors[:full_dates].any?
            return render :json => {status: -1, conflicts: errors[:full_dates]}
          else
            return render :json => {status: -1}
          end
       end
    end
    return render :json => { status: 1 }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_reservations_params
      params.require(:reservation).permit(:listing_id, :advertiser_id, :advertisement_id, dates: [ :start_date, :end_date, :price])
    end
   
    def get_reservations_params
      params.permit(:listing_id, :start_date, :end_date)
    end
end

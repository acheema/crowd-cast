class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    reservation_params = create_reservation_params
    status = true    
    puts "hello"
    puts reservation_params
    puts "yello"

    # lets verify these entries actually exist
    username = cookies[:username]
    advertiser = Advertiser.find_by_username(username)
    listing = Listing.find(reservation_params[:listing_id])
    advertisement = Advertisement.find(reservation_params[:advertisement_id])
    reservation_params.delete("listing_id")
    reservation_params.delete("advertisement_id")
    reservation_params.merge!(:advertiser => advertiser, :listing => listing, :advertisement => advertisement)
    
    # For each reservation, create
    dates = reservation_params[:dates]
    reservation_params.delete("dates")
    dates.each do |reservation|
       status = Reservation.create(reservation_params.merge(:start_date => reservation[:start_date],  
                                                            :end_date => reservation[:end_date], 
                                                            :price => reservation[:price] ))
       if not status 
          break
       end
    end
    if status
      render :json => { status: 1 }
    else
      render :json => { status: -1 }
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_reservation_params
      param = params.permit(dates: [ :start_date, :end_date, :price])
      params.require(:reservation).permit(:listing_id, :advertiser_id, :advertisement_id).merge!(param)
    end
end

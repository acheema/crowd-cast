#Default

class AdvertisersController < ApplicationController
  before_action :set_advertiser, only: [:show, :edit, :update, :destroy]

  # GET /advertisers
  # GET /advertisers.json
  def index
    @advertisers = Advertiser.all
  end

  # GET /advertisers/1
  # GET /advertisers/1.json
  def show
  end

  # GET /advertisers/new
  def new
    @advertiser = Advertiser.new
  end

  # GET /advertisers/1/edit
  def edit
  end

  # POST /advertisers
  # POST /advertisers.json
  def create
    @advertiser = Advertiser.new(advertiser_params)

    respond_to do |format|
      if @advertiser.save
        format.html { redirect_to @advertiser, notice: 'Advertiser was successfully created.' }
        format.json { render :show, status: :created, location: @advertiser }
      else
        format.html { render :new }
        format.json { render json: @advertiser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertisers/1
  # PATCH/PUT /advertisers/1.json
  def update
    respond_to do |format|
      if @advertiser.update(advertiser_params)
        format.html { redirect_to @advertiser, notice: 'Advertiser was successfully updated.' }
        format.json { render :show, status: :ok, location: @advertiser }
      else
        format.html { render :edit }
        format.json { render json: @advertiser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisers/1
  # DELETE /advertisers/1.json
  def destroy
    @advertiser.destroy
    respond_to do |format|
      format.html { redirect_to advertisers_url, notice: 'Advertiser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def advertiser_dashboard
    @current_ads = Advertisement.getAds(@current_user.id)
    @messages = Message.getMessages(cookies[:username])
    @favorites = Advertiser.get_favorited_listings @current_user.id
    #reset the cookie to advertiser view and reset the dashboard state
    self.reset_cookie
    render 'advertiser_dashboard'
  end

  def advertiser_dashboard_ads
    @current_ads = Advertisement.getAds(@current_user.id)
    self.reset_cookie
    render 'advertiser_dashboard_ads'
  end

  def advertiser_dashboard_mail
    @messages = Message.getMessages(cookies[:username])
    self.reset_cookie
    render 'advertiser_dashboard_mail'
  end


  def reset_cookie
    cookies.permanent[:dashboard_state] = 0
    @dashboard_state = 0
  end

  def favorite_listing
    username = cookies[:username]
    listing_id = params[:listing_id]
    if username and listing_id
      advertiser = Advertiser.find_by_username(cookies[:username])
      success = advertiser.favorite_listing(listing_id)
      if success
        render :json => { :success => "success", :status_code => "200" }
      else
        render :json => { :success => "failure", :status_code => "200" }
      end
    else
      render :json => { :success => "failure", :status_code => "200" }
    end
  end

  def unfavorite_listing
    username = cookies[:username]
    listing_id = params[:listing_id]
    if username and listing_id
      advertiser = Advertiser.find_by_username(cookies[:username])
      success = advertiser.unfavorite_listing listing_id 
      if success
        render :json => { :success => "success", :status_code => "200" }
      else
        render :json => { :success => "failure", :status_code => "200" }
      end
    else
      render :json => { :success => "failure", :status_code => "200" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advertiser
      @advertiser = Advertiser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advertiser_params
      params.require(:advertiser).permit(:username, :password_salt, :password_hash, :email, :company, :usertype)
    end
end

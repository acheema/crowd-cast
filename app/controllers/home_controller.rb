# Written by Jason
# World written by Jhoong (to be discarded)
class HomeController < ApplicationController
  def index
  end

  def login
  end

  def signup
  end

  def world
  end

  helper_method :current_user
  before_filter :set_current_user

private
def set_current_user
  if cookies[:username]
   #if usertype ==2 just query the advertiser database....if they are both an advertiser and owner, then the information is in both databases
   if cookies[:usertype] == "0" || cookies[:usertype] == "2"
     @current_user ||= Advertiser.find_by(username: cookies[:username])
  
   elsif cookies[:usertype] == "1"
     @current_user ||= Owner.find_by(username: cookies[:username])
   # user is both an advertiser and owner
 end
end
end
rescue ActiveRecord::RecordNotFound
 session[:user_id] = nil
end


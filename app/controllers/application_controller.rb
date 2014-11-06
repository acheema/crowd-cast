# Written by Jessica

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   #protect_from_forgery with: :exception
   #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

   before_filter :set_cache_buster
   helper_method :set_current_user
   before_filter :set_current_user

private
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

def set_current_user
   if cookies[:username]
    #if usertype ==2 just query the advertiser database....if they are both an advertiser and owner, then the information is in both databases
    if cookies[:usertype] == "0"
      @current_user ||= Advertiser.find_by(username: cookies[:username])
      @dashboard_state = 0
    elsif cookies[:usertype] == "1"
      @current_user ||= Owner.find_by(username: cookies[:username])
      @dashboard_state = 1
    # user is both an advertiser and owner
  elsif cookies[:usertype] == "2"
    if cookies[:dashboard_state] == 0
      @dashboard_state = 0
    else
      @dashboard_state = 1
    end
  end
end
rescue ActiveRecord::RecordNotFound
  session[:user_id] = nil
end

end

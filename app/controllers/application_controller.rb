# Written by Jessica

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   #protect_from_forgery with: :exception
   #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

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
    p 'current user is ', @current_user.username, 'and the number is', @current_user.usertype==1
  end
  
end
rescue ActiveRecord::RecordNotFound
  session[:user_id] = nil
end

end

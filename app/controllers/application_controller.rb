# Written by Jessica

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   #protect_from_forgery with: :exception
   #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

   helper_method :current_user

  private
  def current_user
    if cookie[:username]
      #if usertype ==2 just query the advertiser database....if they are both an advertiser and owner, then the information is in both databases
      if cookie[:usertype] == 0 || cookie[:usertype] == 2:

        @current_user ||= Advertiser.find(cookie[:username]) if cookie[:username]

      elsif cookie[:usertype] == 1:
        @current_user ||= Owner.find(cookie[:username]) if cookie[:username]
      # user is both an advertiser and owner
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
end
end

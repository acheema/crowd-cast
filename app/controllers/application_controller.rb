# Written by Jessica, few changes by Jhoong

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   #protect_from_forgery with: :exception
   #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }

   before_filter :set_cache_buster, :set_current_user
   helper_method :set_current_user

   # POST /api/TESTAPI_tests
   def tests(command="rake test RAILS_ENV=test")
      # Run the command
      output = `#{command}`
      output_split = output.split("\n")
      result_line = nil
      # For each line in the shell output
      output_split.each do |output_line|
         # Match it with "%d example(s), %d failure(s)" that appears after running rspec
         correct_line_match = output_line.match /(\d+)\s+example(?:s)?,\s+(\d+)\s+failure(?:s)?/
         if correct_line_match
            result_line = correct_line_match
            break
         end
      end

      # If we found the matching result line, then the command didn't error out
      if result_line
         render :json => { nrFailed: result_line[2].to_i, output: output, totalTests: result_line[1].to_i }
      else
         render :json => { output: output }
      end
   end
 
private
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

def set_current_user
   if cookies[:username]
    #if usertype ==2 just query the advertiser database....if they are both an advertiser and owner, then the information is in both databases
   @usertype = cookies[:usertype]
   if cookies[:usertype] == "0"
      @current_user ||= Advertiser.find_by(username: cookies[:username])
      @dashboard_state = 0
    elsif cookies[:usertype] == "1"
      @current_user ||= Owner.find_by(username: cookies[:username])
      @dashboard_state = 1
    # user is both an advertiser and owner
  elsif cookies[:usertype] == "2"
    if cookies[:dashboard_state] == "0"
      @current_user ||= Advertiser.find_by(username: cookies[:username])
      @dashboard_state = 0
    else
      @current_user ||= Owner.find_by(username: cookies[:username])
      @dashboard_state = 1
    end
  end
end
rescue ActiveRecord::RecordNotFound
  session[:user_id] = nil
end

end

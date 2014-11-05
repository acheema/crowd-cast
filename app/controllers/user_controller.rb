# Written by Jhoong Roh a few lines by Jason Clark
class UserController < ApplicationController

   def new
     @user = User.new
   end
   
    SUCCESS = 1

    # Create a user
    def createUser
         status = 0
         # Depending on usertype, create an Advertiser or Owner
         params = create_params
         type = params[:usertype]
         if type.eql? "0" or type.equal? 0
            status = Advertiser.createUser params
         elsif type.eql? "1" or type.equal? 1
            status = Owner.createUser(params)
         #user exists and wants to add user type
         elsif type.eql? "2" or type.equal? 2
            usertype = cookies[:usertype] 
            #user is already an advertiser
            if usertype.equal? 0 or usertype.eql? '0'
                status = Owner.createUser(params)
            #user is already an owner
            elsif usertype.equal? 1 or usertype.eql? '1'
                status = Advertiser.createUser(params)
            end
         else
            #Should never reach here
            render :json => { status: -5 } and return
         end

         # If it's a string, then it was a success
         # Else, then it was a failure
         if status.is_a? String
            cookies[ :username ] = status
            render :json => { status: SUCCESS }
         else
            render :json => { status: status }
         end
    end

    # Login user
    def loginUser
        #If they're an advertiser, then render and return
        status = Advertiser.validateUser login_params
        if status.is_a? String
           cookies[ :username ] = status
           cookies[:usertype] = 0
           render :json => { status: SUCCESS } and return
        end

        #If they aren't an advertiser, they might be an owner
        status = Owner.validateUser login_params
        if status.is_a? String
           cookies[ :username ] = status
           cookies[:usertype] = 1
           render :json => { status: SUCCESS }
        else
           render :json => { status: status }
        end
    end

    def 

    # Signout just deletes the cookie
    def signoutUser
        cookies.delete :username
        redirect_to root_path
    end

    # Clean out the tables
    def resetFixture
        Owner.TESTAPI_resetFixture
        Advertiser.TESTAPI_resetFixture
        render :json => { status: SUCCESS }
    end

    private
    # The necessary parameters for creating an owner/advertiser
    def create_params
        params.require(:user).permit(:username, :password, :email, :company, :usertype)
    end

    # The necessary parameter for logging in an owner/advertiser
    def login_params
        params.require(:user).permit(:username, :password)
    end
end

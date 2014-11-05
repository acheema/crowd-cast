# Written by Jhoong Roh a few lines by Jason Clark
class UserController < ApplicationController

   def new
     @user = User.new
   end

    SUCCESS = 1
    FAILURE = -1

    # Create a user
    def createUser
         user = 0
         # Depending on usertype, create an Advertiser (0) or Owner (1)
         params = create_params
         type = params[:usertype]
         if type.eql? "0" or type.equal? 0
            user = Advertiser.createUser params
         elsif type.eql? "1" or type.equal? 1
            user = Owner.createUser(params)
         #user exists and wants to add user type
         elsif type.eql? "2" or type.equal? 2
            current_type = cookies[:usertype]
            #user is already an owner and signed up to also to be an advertiser
            if current_type.equal? 1 or current_type.eql? '1'
               owner = Owner.find_by_username(cookies[:username])
               user = Advertiser.createUser({:username => owner.username, \
                                        :password => 'dummy password', \
                                        :company => owner[:company], \
                                        :usertype => 2, \
                                        :email => owner.email})
               owner.update_attributes :usertype => 2
               user.update_attributes :password_hash => owner.password_hash,
                                      :password_salt => owner.password_salt


            #user is already an advertiser and signed up to also be an owner
            elsif current_type.equal? 0 or current_type.eql? '0'
               advertiser = Advertiser.find_by_username(cookies[:username])
               user = Owner.createUser({:username => advertiser.username, \
                                        :password => 'dummy password', \
                                        :company => create_params[:company], \
                                        :usertype => 2, \
                                        :email => advertiser.email})
               advertiser.update_attributes :usertype => 2
               user.update_attributes :password_hash => advertiser.password_hash,
                                      :password_salt => advertiser.password_salt

            end
         else
            #Should never reach here
            render :json => { status: -5 } and return
         end

         # If it's a string, then it was a success
         # Else, then it was a failure

         if not user.is_a? Integer
            cookies[ :username ] = user.username
            cookies[ :usertype ] = user.usertype
            #set a permanent cookie to save state of dashboard
            # save dashboard state -- users now have the ability to toggle between dashboard states
            cookies.permanent[:dashboard_state] = user.usertype
            render :json => { status: SUCCESS }
         else
            render :json => { status: user }
         end
    end

    # Login user
    def loginUser
        #If they're an advertiser, then render and return
        advertiser = Advertiser.validateUser login_params
        if not advertiser.is_a? Integer
           cookies[ :username ] = advertiser.username
           cookies[:usertype] = advertiser.usertype
           render :json => { status: SUCCESS } and return
        end

        #If they aren't an advertiser, they might be an owner
        owner = Owner.validateUser login_params
        if not owner.is_a? Integer
           cookies[ :username ] = owner.username
           cookies[:usertype] = owner.usertype
           render :json => { status: SUCCESS }
        else
           render :json => { status: FAILURE }
        end
    end

    # Signout just deletes the cookie
    def signoutUser
        cookies.delete :username
        cookies.delete :usertype
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

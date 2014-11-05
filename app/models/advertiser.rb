# Written by: Jhoong Roh and a few lines by Jason Clark
class Advertiser < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password
  validates :password, presence: true, length: { maximum: 128, minimum: 8 }
  validates :username, presence: true, length: { maximum: 128, minimum: 6 }, uniqueness: true
  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates :usertype, presence: true

  def self.validateUser(params)
    user = find_by_username( params[ :username ] )
    # Because we salted and hashed, we have to do this to check the password
    if user && user.password_hash == BCrypt::Engine.hash_secret( params[ :password ], user.password_salt )
      return user.username
    else
      return -1
    end
  end

  def self.createUser(params)
    usertype = params[:usertype]
    #check if the user is adding additional usertype
    if usertype.equal? 2 or usertype.eql? '2'
      if not Owner.exists? :username => params[:username]
        #trying to add addtional user type when username does not exist in Owner table
        return -1
      end
    else
      # Verify that the username doesn't already exist in the Owner table
      if Owner.exists?( :username => params[ :username ])
          return -1
      end
    end


    advertiser = Advertiser.new(params)
    if advertiser.save
      return advertiser.username
    else
      usernameError = advertiser.errors[:username]
      pwError = advertiser.errors[:password]
      emailError = advertiser.errors[:email]
      if usernameError.any?
        if usernameError.include? "has already been taken"
          return -1
        else
          #At this point, something is wrong with the username
          return -2
        end
      elsif pwError.any?
        return -3
      elsif emailError.any?
        return -4
      end
    end
  end

  # Clear out the table
  def self.TESTAPI_resetFixture
    Advertiser.delete_all
  end

  # We want to salt and hash to prevent rainbow dictionary exploits
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end

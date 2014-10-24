# Written by: Jhoong Roh
class Owner < ActiveRecord::Base
  has_many :listings    
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
    # Verify that the username doesn't already exist in the Advertiser table
    if Advertiser.exists?( :username => params[ :username ])
        return -1
    end
   
    owner = Owner.new(params)
    if owner.save
      return owner.username
    else
      usernameError = owner.errors[:username]
      pwError = owner.errors[:password]
      emailError = owner.errors[:email]
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
    Owner.delete_all
  end

  # We want to salt and hash to prevent rainbow dictionary exploits
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end



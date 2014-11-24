# Written by Jhoong
class Message < ActiveRecord::Base
  belongs_to :listing
  validates :to_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates :from_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates :text, presence: true, length: { minimum: 6 }
  validates_format_of :viewed, :with => /\A\d{4}-\d{2}-\d{2}\z/, :if => [:viewed?]
  validates :message_type, presence: true, :inclusion => {:in => [0, 1]}
  validates :listing, :presence => true 
  validates :listing_title, presence: true
  validate :to_username_exists?
  validate :from_username_exists?

  def to_username_exists?
    if not (Owner.where( :username => self.to_username ).any? or Advertiser.where( :username => self.to_username ).any?)
       errors.add(:to_username, "invalid to_username")
    end
  end

  def from_username_exists?
    if not (Owner.where( :username => self.from_username ).any? or Advertiser.where( :username => self.from_username ).any?)
      errors.add(:from_username, "invalid from_username")
    end
  end
      

  def self.createMessage(params)
      message = Message.new(params)
      if message.save
         return 1
      else
         errors = message.errors
         if errors[:to_username].any?
            return -1
         elsif errors[:from_username].any?
            return -2
         elsif errors[:text].any?
            return -3
         elsif errors[:viewed].any?
            return -4
         elsif errors[:listing].any?
            return -5
         elsif errors[:listing_title].any?
            return -6
         else
            return -7
         end
      end
  end

  def self.getMessages(to_username)
      messages = Message.where( "to_username = '#{to_username}'" ).all
      return messages
  end
  
  # Clear out the table
  def self.TESTAPI_resetFixture
    Message.delete_all
  end
end

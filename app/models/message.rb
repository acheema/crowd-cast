class Message < ActiveRecord::Base
  belongs_to :listing
  validates :to_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates :from_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates_presence_of :text
  validates_format_of :viewed, :with => /\A\d{4}-\d{2}-\d{2}\z/, :if => [:viewed?]
  validates :message_type, presence: true, :inclusion => {:in => [0, 1]}
  validates :listing, :presence => true 

  def self.createMessage(params)
      message = Message.new(params)
      if message.save
         return 1
      else
         if message.errors.any?
            return -1
         end
      end
  end

  def self.getMessages(to_username)
      messages = Message.where( "to_username = '#{to_username}'" ).all
      return messages
  end
end

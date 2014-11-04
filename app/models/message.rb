class Message < ActiveRecord::Base
  belongs_to :listing
  validates :to_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates :from_username, presence: true, length: { maximum: 128, minimum: 6 }
  validates_presence_of :message
  validates_format_of :viewed, :with => /\A\d{4}-\d{2}-\d{2}\z/
  validates :type, presence: true, :inclusion => {:in => [0, 1]}
  validates :listing, :presence => true 

  def createMessage(params)
      message = Listing.new(params.merge(:type => 1))
      if listing.save
         return listing.id
      else
         errors = listing.errors
      end
  end

  def getMessages(to_username)
  end

end

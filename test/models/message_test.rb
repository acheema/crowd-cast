# Written by Jhoong
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  #def self.getMessages(to_username)
  #    messages = Message.where( "to_username = '#{to_username}'" ).all
  #    return messages
  #end
  
  def setup
    params = { username: "Valid Username", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 1 }
    @owner = Owner.create(params)
    params = { username: "Valid Username 2", password: "valid password", email: "bob@cnn.com", company: "Some Company", usertype: 0 }
    @advertiser = Advertiser.create(params)
    
    params = {
    	title: "Listing 1", 
    	height: 30, 
    	width: 31, 
    	time_per_click: 8, 
		views_per_week: 8, 
		cost_per_day: 100, 
		street: "College Ave", 
		city: "Berkeley", 
		state: "CA", 
		zip: "94704", 
		owner: @owner,
      screen_resolution_x: 56,
      screen_resolution_y: 57,
	   active: true,
      views: 0,
   }
   @listing = Listing.create(params)
 end

  #validates :to_username, presence: true, length: { maximum: 128, minimum: 6 }
  test "invalid to_username username" do
      #Blank to_username
      params = { to_username: "", from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      
      assert_equal(-1, Message.createMessage(params), "Invalid to_username") 
  
      #Too short to_username
      params = { to_username: "a" * 5, from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-1, Message.createMessage(params), "Invalid to_username") 
      
      #Too long to_username
      params = { to_username: "a" * 129, from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-1, Message.createMessage(params), "Invalid to_username") 
      
      #Valid to_username
      params = { to_username: @advertiser.username, from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(1, Message.createMessage(params), "Invalid to_username") 
   end

  #validates :from_username, presence: true, length: { maximum: 128, minimum: 6 }
  test "invalid from_username username" do
      #Blank from_username
      params = { to_username: "Valid Username", from_username: "", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      
      assert_equal(-2, Message.createMessage(params), "Invalid from_username") 
  
      #Too short from_username
      params = { to_username: "Valid Username", from_username: "a" * 5, text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-2, Message.createMessage(params), "Invalid from_username") 
      
      #Too long from_username
      params = { to_username: "Valid Username", from_username: "a" * 129, text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-2, Message.createMessage(params), "Invalid from_username") 
      
   end

  #validates :text, presence: true, length: { minimum: 6 }
  test "invalid text" do
      #Blank text
      params = { to_username: "Valid Username", from_username: "Valid Username 2", text: "", message_type: "1", listing: @listing, listing_title: @listing.title }
      
      assert_equal(-3, Message.createMessage(params), "Invalid text") 
  
      #Too short text
      params = { to_username: "Valid Username", from_username: "Valid Username 2", text: "a" * 5, message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-3, Message.createMessage(params), "Invalid text") 
   end

  #validates_format_of :viewed, :with => /\A\d{4}-\d{2}-\d{2}\z/, :if => [:viewed?]
  test "invalid viewed" do
      #Incorrect viewed
      params = { viewed: "00-00-00", to_username: "Valid Username", from_username: "Valid Username 2", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(-4, Message.createMessage(params), "Invalid text") 
      
      #Correct viewed
      params = { viewed: "0000-00-00", to_username: "Valid Username", from_username: "Valid Username 2", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      assert_equal(1, Message.createMessage(params), "Invalid text") 
   end

  #validates :listing, :presence => true 
  test "invalid listing" do
      #Bad listing
      params = { to_username: "Valid Username", from_username: "Valid Username 2", text: "Valid text", message_type: "1", listing_title: @listing.title }
      assert_equal(-5, Message.createMessage(params), "Invalid listing") 
   end
  
   #validates :listing_title, :presence => true 
  test "invalid listing_title" do
      #Bad listing_title
      params = { to_username: "Valid Username", from_username: "Valid Username 2", text: "Valid text", message_type: "1", listing: @listing }
      assert_equal(-6, Message.createMessage(params), "Invalid listing_title") 
   end

  test "getMessage" do
      messages = Message.getMessages("Valid Username") 
      assert_equal(false, messages.any?, "Should have no messages") 
      
      params = { to_username: @advertiser.username, from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      Message.createMessage(params)
      assert_equal(params[:to_username], Message.getMessages(@advertiser.username)[0].to_username, "Should have one message") 
      assert_equal(params[:from_username], Message.getMessages(@advertiser.username)[0].from_username, "Should have one message") 
      assert_equal(params[:text], Message.getMessages(@advertiser.username)[0].text, "Should have one message") 
      assert_equal(params[:listing_title], Message.getMessages(@advertiser.username)[0].listing_title, "Should have one message") 
  end    

  test "resetFixture" do
      params = { to_username: @advertiser.username, from_username: "Valid Username", text: "Valid text", message_type: "1", listing: @listing, listing_title: @listing.title }
      Message.createMessage(params)
     messages = Message.TESTAPI_resetFixture
     assert_equal(false, Message.all.any?, "no entries")
  end
end

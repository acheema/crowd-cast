# Written by Jhoong
class MessagesController < ApplicationController

  # Just create the message in the message table
  def sendMessage
    username = cookies[:username]
    message = Message.createMessage(message_params.merge( :from_username => username, \
                                                          :message_type => 1 ))
    render :json => { status: message }
  end

  def TESTAPI_resetFixture
     Message.TESTAPI_resetFixture
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:listing_id, :listing_title, :to_username, :text)
    end
end

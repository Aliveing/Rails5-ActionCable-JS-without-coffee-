class ChatController < ApplicationController
  protect_from_forgery with: :null_session

  def root
    redirect_to '/main/index'
  end

  def create
    ChatChannel.speak(params)
    render :text => {success:true}.to_json, :layout => false
  end

  def get_all
    json = {
        success:true,
        data: Message.all
    }
    render :text => json.to_json, :layout => false
  end

end

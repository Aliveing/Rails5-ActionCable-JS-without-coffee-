class ChatController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, :only => [:create]
  def root
    redirect_to '/main/index'
  end

  def create
    # App.chat.speak(params)
    puts params.to_json
    Message.create(content:params[:content],name:params[:name])
    ActionCable.server.broadcast 'chat_channel', message:params[:content]
    render :text => {success:true}.to_json, :layout => false
  end

  def get_all
    json = {
        success:true,
        data: Message.all
    }
    render :plain => json.to_json, :layout => false
  end

end

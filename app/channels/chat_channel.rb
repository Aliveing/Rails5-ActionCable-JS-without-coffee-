# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    Message.create(content:data['content'],name:data['name'])
    msg = {
        content:data["content"],
        refresh:true
    }
    ActionCable.server.broadcast 'chat_channel', msg
  end
end

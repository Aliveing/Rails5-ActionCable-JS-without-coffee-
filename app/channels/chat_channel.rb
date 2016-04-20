# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  @@channel_map = Hash.new
  def subscribed
    puts "xxxxx"
    puts params.to_json
    puts "xxxxx"
    stream_from params[:channel] + params[:sid].to_s
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive data
    puts "xxx"
    puts params.to_json
    puts "xxx"
    Message.create(content:data['content'],name:data['name'])
    msg = {
        content:data["content"],
        refresh:true
    }
    ActionCable.server.broadcast params[:channel] + params[:sid].to_s, msg
  end
end

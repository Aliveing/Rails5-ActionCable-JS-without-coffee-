class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    render "layouts/application"
  end

  def create
    num = Count.all.length
    Count.create(count:num + 1,refresh_time:Time.now)
    render :text => {success:true}.to_json, :layout => false
  end
end

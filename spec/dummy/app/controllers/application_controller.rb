class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    user = User.new
    user.id = session[:user_id]
    return user
  end
end

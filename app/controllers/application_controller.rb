class ApplicationController < ActionController::Base
  protect_from_forgery
  @@current_user = nil
  helper_method :current_user

  def set_current_user(user)
  	@@current_user = user
  end

  def current_user
  	@@current_user
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  @@current_user = nil
  helper_method :current_user

  def set_current_user(user)
  	@@current_user = user
  	session["picviewer_user"] = user.id
  end

  def current_user
  	return nil if session["picviewer_user"].nil?
  	@@current_user ||= User.find(session["picviewer_user"])
  end

  def logout
  	session["picviewer_user"] = nil
  	@@current_user = nil
    redirect_to root_path
  end

end

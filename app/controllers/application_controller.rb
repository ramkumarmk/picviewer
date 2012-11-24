class ApplicationController < ActionController::Base
  protect_from_forgery
  @@current_user = nil
  @@refresh_token = nil
  helper_method :current_user

  def set_current_user(user)
  	@@current_user = user
  	session["picviewer_user"] = user.id
  end

  def current_user
  	return nil if session["picviewer_user"].nil?
  	@@current_user ||= User.find(session["picviewer_user"])
  end

  def save_refresh_token(refresh_token)
    session['picviewer_refresh_token'] = refresh_token
  end

  def refresh_token
    @@refresh_token ||= session['picviewer_refresh_token']
  end

  def logout
  	session["picviewer_user"] = nil
    session["picviewer_refresh_token"] = nil
  	@@current_user = nil
    @@refresh_token = nil
    redirect_to root_path
  end

  def request_access_token
      token_url = URI.parse('https://accounts.google.com/o/oauth2/token')
      token_req = Net::HTTP::Post.new(token_url.path)
      token_req.set_form_data({ 'code' => params['code'], 'client_id' => APP_CONFIG["client_id"], 'client_secret' => APP_CONFIG["client_secret"], 'redirect_uri' => APP_CONFIG["redirect_uri"], 'grant_type' => 'authorization_code' })
      token_http = Net::HTTP.new(token_url.host, token_url.port)
      token_http.use_ssl = true
      token_response_json = token_http.request(token_req)
      json_data = JSON.parse(token_response_json.body)
      save_refresh_token json_data["refresh_token"]
      json_data["access_token"]
  end

  def refresh_access_token
      token_url = URI.parse('https://accounts.google.com/o/oauth2/token')
      token_req = Net::HTTP::Post.new(token_url.path)
      token_req.set_form_data({ 'refresh_token' => refresh_token, 'client_id' => APP_CONFIG["client_id"], 'client_secret' => APP_CONFIG["client_secret"],  'grant_type' => 'refresh_token' })
      token_http = Net::HTTP.new(token_url.host, token_url.port)
      token_http.use_ssl = true
      token_response_json = token_http.request(token_req)
      json_data = JSON.parse(token_response_json.body)
      json_data["access_token"]
  end

end
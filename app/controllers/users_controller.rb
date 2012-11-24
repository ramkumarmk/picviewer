class UsersController < ApplicationController
	
	def create_user_session
		access_token = request_access_token
		user_info = get_user_info_json(access_token)
	    user = User.find_or_create_by_email(email: user_info["email"], name: user_info["name"])
	    set_current_user(user)
	    redirect_to user_album_index_path
	end

	private

	def request_access_token
		token_url = URI.parse('https://accounts.google.com/o/oauth2/token')
	    token_req = Net::HTTP::Post.new(token_url.path)
	    token_req.set_form_data({ 'code' => params['code'], 'client_id' => APP_CONFIG["client_id"], 'client_secret' => APP_CONFIG["client_secret"], 'redirect_uri' => APP_CONFIG["redirect_uri"], 'grant_type' => 'authorization_code' })
	    token_http = Net::HTTP.new(token_url.host, token_url.port)
	    token_http.use_ssl = true
	    token_response_json = token_http.request(token_req)
	    JSON.parse(token_response_json.body)["access_token"]
	end

	def get_user_info_json(access_token)
		url = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?fields=email,name&access_token=#{access_token}")
	    http = Net::HTTP.new(url.host, url.port)
	    http.use_ssl = true
	    request = Net::HTTP::Get.new(url.request_uri)
	    JSON.parse(http.request(request).body)
	end
end
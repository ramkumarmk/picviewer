class UsersController < ApplicationController
	
	def create_user_session
		access_token = request_access_token
		user_info = get_user_info_json(access_token)
	    user = User.find_or_create_by_email(email: user_info["email"], name: user_info["name"])
	    set_current_user(user)
	    redirect_to user_album_index_path
	end

	private

	def get_user_info_json(access_token)
		url = URI.parse("https://www.googleapis.com/oauth2/v1/userinfo?fields=email,name&access_token=#{access_token}")
	    http = Net::HTTP.new(url.host, url.port)
	    http.use_ssl = true
	    request = Net::HTTP::Get.new(url.request_uri)
	    JSON.parse(http.request(request).body)
	end
end
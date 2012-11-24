require "net/http"
module PicasaUser
	def get_albums
		url = URI.parse("https://picasaweb.google.com/data/feed/api/user/#{email}?alt=json")
	    http = Net::HTTP.new(url.host, url.port)
	    http.use_ssl = true
	    request = Net::HTTP::Get.new(url.request_uri)
	    Album.convert_to_albums(OpenStruct.new(JSON.parse(http.request(request).body)).feed["entry"])
	end
end
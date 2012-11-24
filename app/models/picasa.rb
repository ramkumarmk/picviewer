require "net/http"
class Picasa
	def self.get_albums(email)
		url = URI.parse("https://picasaweb.google.com/data/feed/api/user/#{email}?alt=json")
	    http = Net::HTTP.new(url.host, url.port)
	    http.use_ssl = true
	    request = Net::HTTP::Get.new(url.request_uri)
	    entries = OpenStruct.new(JSON.parse(http.request(request).body)).feed["entry"]
	    Album.convert_to_albums(entries)
	end

	def self.get_photos(email, albumId)
		url = URI.parse("https://picasaweb.google.com/data/feed/api/user/#{email}/albumid/#{albumId}?alt=json")
	    http = Net::HTTP.new(url.host, url.port)
	    http.use_ssl = true
	    request = Net::HTTP::Get.new(url.request_uri)
	    entries = OpenStruct.new(JSON.parse(http.request(request).body)).feed["entry"]
	    return [] if entries.nil?
	    Photo.convert_to_photos(entries)
	end
end
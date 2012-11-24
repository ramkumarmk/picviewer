require "net/http"
require 'builder'
class CommentsController < ApplicationController
	def create
		album_id = params[:album_id]
		content = params[:content]
		photo_id = params[:photo_id]

		access_token = refresh_access_token

		x = Builder::XmlMarkup.new(:target => out_string = "<entry xmlns='http://www.w3.org/2005/Atom'>\n<content>#{content}</content>\n<category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#comment'/>\n</entry>", :indent =>1)
		uri = URI.parse("https://picasaweb.google.com/data/feed/api/user/#{current_user.email}/albumid/#{album_id}/photoid/#{photo_id}?access_token=#{access_token}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.request_uri, {'content-type' => 'application/atom+xml' })

        request.body = out_string

        response = http.request(request)
		# url = URI.parse("https://picasaweb.google.com/data/feed/api/user/#{email}?alt=json")
	 #    http = Net::HTTP.new(url.host, url.port)
	 #    http.use_ssl = true
	 #    request = Net::HTTP::Post.new(url.request_uri)
	 	flash[:notice] = "Your comment posted successfully, will appear in comments panel in few seconds"
		redirect_to user_album_photo_index_path(album_id)
	end
end
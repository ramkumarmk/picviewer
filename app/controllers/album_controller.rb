class AlbumController < ApplicationController
	def index
		@albums = current_user.get_albums
	end
end
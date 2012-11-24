class UsersController < ApplicationController
	def album_index
		@albums = current_user.get_albums
	end
end
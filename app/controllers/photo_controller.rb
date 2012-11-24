class PhotoController < ApplicationController
	def index
		@photos = current_user.album(params[:album_id]).get_photos
	end
end
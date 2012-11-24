class User < ActiveRecord::Base
	attr_accessible :email, :name

	def get_albums
		Picasa.get_albums(email)
	end

	def album(id)
		Album.new(id: id, user: email)
	end
end
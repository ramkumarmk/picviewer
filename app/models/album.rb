class Album
	include ActiveModel::Serialization
	
	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end

	def attributes
		OpenStruct.new(@attributes)
	end

	def self.convert_to_albums(album_json_arr)
		album_json_arr.collect do |album|
			Album.new(title: album["media$group"]["media$title"]["$t"] , published_date:album["published"]["$t"],
				summary: album["summary"]["$t"], 
				link: album["link"].first["href"], 
				thumbnail:album["media$group"]["media$thumbnail"].first["url"])
			
		end
	end
end
class Photo
	include ActiveModel::Serialization

	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end

	def attributes
		OpenStruct.new(@attributes)
	end

	def self.convert_to_photos(photos_json_arr)
		photos = []
		(0..2).collect do |index|
			photo = photos_json_arr[index]
			break if photo.nil?
			
			photos << Photo.new(image_uri: photo["media$group"]["media$content"].first["url"],
				id: photo["gphoto$id"]["$t"],
				summary: photo["summary"]["$t"])
		end
		photos
	end
end
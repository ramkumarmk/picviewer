class Photo
	include ActiveModel::Serialization

	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end

	def attributes
		OpenStruct.new(@attributes)
	end

	def set_attribute(hash)
		@attributes[hash.first.first] = hash.first.last
	end


	def self.convert_to_photos(photos_json_arr)
		photos_json_arr.collect do |photo|
			Photo.new(image_uri: photo["media$group"]["media$content"].first["url"],
				id: photo["gphoto$id"]["$t"],
				summary: photo["summary"]["$t"])
		end
	end
end
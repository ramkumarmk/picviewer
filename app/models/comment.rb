class Comment
	include ActiveModel::Serialization
	attr_accessor :attributes
	def initialize(attributes)
		@attributes = attributes
	end

	def attributes
		OpenStruct.new(@attributes)
	end

	
	def self.convert_to_comments(comments_json_arr)
		comments_json_arr.collect do |photo|
			Comment.new(author: photo["title"]["$t"],
				content: photo["content"]["$t"])
		end
	end
end
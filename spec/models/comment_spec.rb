require "spec_helper"
describe "comment" do
	it "should convert comments_json in to comment" do
		comments_json = [{
					"content" => {
                "$t" => "content"
            },
            "title" => {
                "$t" => "Varun Asok"
            }
						}]
		comment = Comment.convert_to_comments(comments_json).first
		comment.attributes.author.should eq("Varun Asok")
		comment.attributes.content.should == "content"
	end
end
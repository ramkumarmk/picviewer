require "spec_helper"
describe "photo" do
	it "should convert json data to photos" do
		photos_json =[{"gphoto$id" => {
                "$t" =>  "123"
            },
            "summary" => {
                "$t" => "summary"
                        },

			"media$group" => {
                "media$content" => [{
                    "url" => "image_uri"}]
                    }}]
		photos = Photo.convert_to_photos(photos_json).first
		photos.attributes.image_uri.should eq("image_uri")
		photos.attributes.id.should == "123"
		photos.attributes.summary.should == "summary"
	end
end

require "spec_helper"
describe "album" do
	it "should convert album_json in to album" do
		album_json = [{
			"published" => {
				"$t" => "2010-11-01"
				}, 
			"summary" => {"$t" => "summary"},
			"link" => [{
					"href" => "album_link"
					}],
			"media$group" => {
					"media$thumbnail" => [{
							"url" => "thumbnail"
							}], "media$title" => {
								"$t" => "Profile Photos"
							}
						}
						}]
		album = Album.convert_to_albums(album_json).first
		album.attributes.published_date.should eq("2010-11-01")
		album.attributes.summary.should == "summary"
		album.attributes.link.should == "album_link"
		album.attributes.title.should == "Profile Photos"
		album.attributes.thumbnail.should == "thumbnail"
	end
end
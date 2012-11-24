require "spec_helper"
describe PhotoController do

	before(:each) do
		@user  = User.create(name: "ram", email: "abc@gmail.com")
		controller.set_current_user(@user)
	end
		
	it "should load all photos in albums" do
		mock_album = mock("album")
		photos = []
		@user.should_receive(:album).with("1").and_return(mock_album)
		mock_album.should_receive(:get_photos).and_return(photos)
		get :index, album_id: 1
		assigns[:photos].should == photos
		response.should render_template(:index)
	end
end
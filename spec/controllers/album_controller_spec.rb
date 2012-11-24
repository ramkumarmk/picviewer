require "spec_helper"

describe AlbumController do
	describe "get albums" do
		before(:each) do
			@user  = mock(:user)
			controller.set_current_user(@user)
		end
		it "should list all album meta details" do
			@user.should_receive(:get_albums).and_return("")
			get :index
			assigns[:albums].should_not be_nil
			response.should render_template(:index)
		end
	end

end 
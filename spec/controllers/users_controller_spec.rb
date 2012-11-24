require 'spec_helper'

describe UsersController do
	describe "get album index" do
		before(:each) do
			@user  = mock(:user)
			controller.set_current_user(@user)
		end
		it "should list all album meta details" do
			@user.should_receive(:get_albums).and_return("")
			get :album_index
			assigns[:albums].should_not be_nil
			response.should render_template(:album_index)
		end
	end
	
end
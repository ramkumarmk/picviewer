require 'spec_helper'

describe HomeController do
	context "Index" do
		it "should render index view" do
			get :index
			response.should render_template(:index)
		end
	end

	context "logout" do
		it "should logout and redirect to root path" do
			controller.should_receive(:set_current_user).with(nil)
			get :logout
			response.should redirect_to(root_path)
		end
	end
	
end
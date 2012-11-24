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
			@user = User.create(name: "ram", email: "abc@gmail.com")
			controller.set_current_user @user
			get :logout
			response.should redirect_to(root_path)
			controller.current_user.should be_nil
		end
	end
	
end
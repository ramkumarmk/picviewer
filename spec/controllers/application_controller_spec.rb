require 'spec_helper'

describe ApplicationController do

	before(:each) do
		@user = User.create(name: "ram", email: "abc@gmail.com")
		controller.set_current_user @user
	end

	it 'should set current user and return the same' do
		controller.current_user.should eq(@user)
	end
end
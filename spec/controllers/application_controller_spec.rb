require 'spec_helper'

describe ApplicationController do

	it 'should return nil if current_user not set' do
		controller.current_user.should be_nil
	end

	it 'should set current user and return the same' do
		user = User.new
		controller.set_current_user user
		controller.current_user.should eq(user)
	end
end
require "spec_helper"
describe "User" do
	it "should load albums" do
		email = "abc@gmail.com"
		user = User.new(email: email, name: "ram")
		Picasa.should_receive(:get_albums).with(email)
		user.get_albums
	end
end
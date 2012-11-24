require "spec_helper"
describe "User" do
	it "should get all albums" do
		email = "abc@gmail.com"
		user = User.new(email: email, name: "ram")

		mockHttp = mock()
		mockUrl = mock(port: "", host: "")
		response = {"feed" => { "entry" => {} }}
		mockResponse = mock(body: {"feed" => { "entry" => {} }}.to_json )

		URI.should_receive(:parse).with("https://picasaweb.google.com/data/feed/api/user/#{email}?alt=json").and_return(mockUrl)
		Net::HTTP.should_receive(:new).and_return(mockHttp)
		mockHttp.should_receive(:use_ssl=).with(true)
		mockUrl.should_receive(:request_uri).and_return("")
		mockHttp.should_receive(:request).and_return(mockResponse)

		Net::HTTP::Get.should_receive(:new)
		user.get_albums

	end
	
end
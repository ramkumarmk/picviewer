require "spec_helper"
describe "picasa" do
	it "should get all albums" do
		email = "abc@gmail.com"

		mockHttp = mock("http")
		mockUrl = mock(port: "", host: "")
		response = {"feed" => { "entry" => {} }}
		mockResponse = mock(body: {"feed" => { "entry" => {} }}.to_json )

		URI.should_receive(:parse).with("https://picasaweb.google.com/data/feed/api/user/#{email}?alt=json").and_return(mockUrl)
		Net::HTTP.should_receive(:new).and_return(mockHttp)
		mockHttp.should_receive(:use_ssl=).with(true)
		mockUrl.should_receive(:request_uri).and_return("")
		mockHttp.should_receive(:request).and_return(mockResponse)
		Album.should_receive(:convert_to_albums)

		Net::HTTP::Get.should_receive(:new)
		Picasa.get_albums(email)
	end

	it "should get all photos in the album" do
		email = "abc@gmail.com"
		albumId = "123"

		mockHttp = mock("http")
		mockUrl = mock(port: "", host: "")
		response = {"feed" => { "entry" => {} }}
		mockResponse = mock(body: {"feed" => { "entry" => {} }}.to_json )

		URI.should_receive(:parse).with("https://picasaweb.google.com/data/feed/api/user/#{email}/albumid/#{albumId}?alt=json&max-results=3").and_return(mockUrl)
		Net::HTTP.should_receive(:new).and_return(mockHttp)
		mockHttp.should_receive(:use_ssl=).with(true)
		mockUrl.should_receive(:request_uri).and_return("")
		mockHttp.should_receive(:request).and_return(mockResponse)
		Photo.should_receive(:convert_to_photos).and_return([])

		Net::HTTP::Get.should_receive(:new)
		Picasa.get_photos(email, albumId)
	end

end
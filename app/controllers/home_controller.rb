require "net/http"
require "uri"
require "json"

class HomeController < ApplicationController

	def index
	end

	def logout
		set_current_user(nil)
		redirect_to root_path
	end
end
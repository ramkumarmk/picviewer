class User < ActiveRecord::Base
	attr_accessible :email, :name
	include PicasaUser
end
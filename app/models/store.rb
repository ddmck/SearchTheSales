class Store < ActiveRecord::Base
	validates_presence_of :name, :url, :image_url
end

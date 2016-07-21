require 'securerandom'

class Url < ActiveRecord::Base
before_save :shorten #always instance method!
#'save' method is in the 'post' request in the controller 'static.rb' file
validates :short_url, uniqueness: {message: "invalid url"}
validates :long_url, uniqueness: {message: "invalid url"}
validates :long_url, uniqueness: {scope: :short_url, message: "invalid url"} 
#same long url generates same short url
validates :long_url, format: { with: /\Ahttp:/,
    message: "invalid url" }

	def shorten
		self.short_url = SecureRandom.hex(3) 
	end
end

#active record callback: http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html


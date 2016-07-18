require 'securerandom'

class Url < ActiveRecord::Base

validates :short_url, uniqueness: true
validates :long_url, uniqueness: true
validates :long_url, uniqueness: {scope: :short_url} #same long url generates same short url
validates :long_url, format: { with: /\Ahttp:..www./,
    message: "please type in http://www. in front" }

	def self.shorten
		SecureRandom.hex(3) 
	end
end



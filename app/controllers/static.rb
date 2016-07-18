require 'byebug'

get '/' do
	@counter = Url.all.count #counting number of short urls generated altogether
	#can't put counter under 'post '/''. Under post, it redirects at the end to the index page, thus counter is lost! 
  erb :"static/index"
end

post '/' do
	url = Url.find_by(long_url: params["long_url"])
	if url
		url.save
		#@counter = Url.all.count #can't put this here!!
	else
		Url.create(long_url: params["long_url"], short_url: Url.shorten)
	end
	redirect "/"
end

get '/:short_url' do

	Url.all.each do |item|
		if item.short_url.include?(params["short_url"])
			redirect item.long_url
			item.count_short_url += 1
			item.save
		end
	end
end


#this is the controller/server that links up the front-end view and back-end database

#'get' is to show a page
#'post' is to do something to the page
#'post' always follows with a 'redirect' since 'post' alone would just generate a blank page

################this is a seperating line ##################

#@hyperlink = Url.find_by(short_url: params["short_url"])
# redirect @hyperlink.long_url
#the above two lines only function as hyperlink, but do not count the number of times people use the hyperlink. 



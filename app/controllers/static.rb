#http://localhost:9393/

require 'byebug'
enable :sessions #enables multiple users to use it from different computers, each computer having a different database

get '/' do
	@url = Url.find(session[:id]) if session[:id]
	@counter = Url.all.count #instance variable will not be carried over by redirect, thus have to declare instance variable at 'get'
  erb :"static/index"
end

#below is how you do it without sessions
##########
# post '/' do
# 	url = Url.find_by(long_url: params["long_url"])
# 	if url 
# 		url.update(updated_at: Time.now)
# 		url.save
# 	else
# 		Url.create(long_url: params["long_url"], short_url: Url.shorten)
# 	end
# 	redirect "/"
# end
##########

post '/' do
	url = Url.find_by(long_url: params["long_url"])
	if url.nil?
		url = Url.create(long_url: params["long_url"], short_url: Url.shorten)
	end
	session[:id] = url.id
	redirect "/"
end

get '/:short_url' do
	hyperlink = Url.find_by(short_url: params["short_url"])
	hyperlink.count_short_url += 1
	hyperlink.save
	redirect hyperlink.long_url

end


#this is the controller/server that links up the front-end view and back-end database

#'get' is to show a page
#'post' is to do something to the page
#'post' always follows with a 'redirect' since 'post' alone would just generate a blank page




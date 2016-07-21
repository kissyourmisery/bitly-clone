#http://localhost:9393/



get '/' do
	@counter = Url.all.count #instance variable will not be carried over by redirect, thus have to declare instance variable at 'get'
  erb :"static/index"
end

#below is an alternative method!
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
	url = Url.find_or_initialize_by(long_url: params["long_url"])
	#this method is like find_or_create_by, but calls new instead of create.
	if url.save
		url.to_json
	else
		url.errors.messages.to_json #no need to redirect with AJAX
	end
end

get '/:short_url' do #the '/:short_url' means that the count will only increase with every click on the short url
	hyperlink = Url.find_by(short_url: params["short_url"])
	hyperlink.count_short_url += 1 #how does the counting work?
	hyperlink.save
	redirect hyperlink.long_url

end


#this is the controller/server that links up the front-end view and back-end database

#difference between 'get' and 'post': http://www.w3schools.com/tags/ref_httpmethods.asp






















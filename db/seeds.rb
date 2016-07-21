file_path = APP_ROOT.join('db', 'urls.txt')
file = IO.readlines(file_path) #giant array and each line is an array
#file[0] = (http://.....),\n => not the actual format of url!!

file.each do |line|
	line.gsub!('(', '')
	line.gsub!(");\n", '')
	new_url = Url.create(long_url: line)
	#new_url.save => don't need since when you create, it saves already!
end




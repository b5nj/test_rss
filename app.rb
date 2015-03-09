require 'sinatra'
require 'rss'
require 'open-uri'
require 'pry'

get '/' do
	feed_url = "http://localhost:3000/?format=rss"
	@output = "<h1>Lecture d'un flux RSS</h1>"
	open(feed_url) do |http|
		response = http.read
		result = RSS::Parser.parse(response, false)
		# binding.pry
		@output += "Titre du flux : #{result.channel.title}<br />"
		result.items.each_with_index do |item, i|
			@output += "#{i+1}. #{item.description}<br />" if i < 20
		end
	end
	erb :index
end
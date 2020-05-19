class TopicsController < ApplicationController

	# => read
	get '/topics' do
		@topics = Topic.all
		erb :'topics/index'
	end

end

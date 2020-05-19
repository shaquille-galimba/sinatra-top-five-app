class TopicsController < ApplicationController

	# => read
	get '/topics' do
		@topics = Topic.all
		erb :'topics/index'
	end

	get '/topics/:slug' do
		@topic = Topic.find_by_slug(params[:slug])
		erb :'topics/show'
	end

end

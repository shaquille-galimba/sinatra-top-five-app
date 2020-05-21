class TopicsController < ApplicationController

	# => read
	get '/topics' do
		if logged_in?
			@topics = Topic.order(:name)
			erb :'topics/index'
		else
			redirect '/'
		end
	end

	get '/topics/:slug' do
		@topic = Topic.find_by_slug(params[:slug])
		erb :'topics/show'
	end

end

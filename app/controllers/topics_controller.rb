class TopicsController < ApplicationController

	# => read
	get '/topics' do
		@topics = Topic.order(:name)
		erb :'topics/index'
	end

	get '/topics/:slug' do
		@topic = Topic.find_by_slug(params[:slug])
		erb :'topics/show'
	end

	post '/topics/:slug/new' do
		if logged_in?
			@topic = Topic.find_by_slug(params[:slug])
			erb :'/lists/new'
		else
			redirect '/'
		end
	end

end

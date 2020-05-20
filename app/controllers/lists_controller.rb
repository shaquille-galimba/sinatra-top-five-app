class ListsController < ApplicationController

	# => create
	get '/lists/new' do
		if logged_in?
			erb :'lists/new'
		else
			redirect '/'
		end
	end

	post '/lists' do
		binding.pry
		if params[:topic_name].empty? || params[:contents].any? {|c| c.empty?}
			redirect '/lists/new'
		else
			@topic = Topic.find_or_create_by(name: params[:topic_name])
			@list = List.new(contents: params[:contents], user_id: current_user.id, topic_id: @topic.id)
			@list.save
		end
	end

end

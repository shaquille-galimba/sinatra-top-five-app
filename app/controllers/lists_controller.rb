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
		if params[:topic_name].empty? || params[:contents].any? {|c| c.empty?}
			redirect '/lists/new'
		else
			@topic = Topic.find_or_create_by(name: params[:topic_name])
			@list = List.new(contents: params[:contents], user_id: current_user.id, topic_id: @topic.id)
			@list.save
			redirect "/lists/#{@list.id}"
		end
	end

	# => read
	get '/lists/:id' do
		if logged_in?
			@list = List.find(params[:id])
			erb :'lists/show'
		else
			redirect '/'
		end
	end

	# => update
	get '/lists/:id/edit' do
		if logged_in?
			@list = List.find(params[:id])
			if @list && @list.user == current_user
				erb :'lists/edit'
			else
				redirect "/lists/#{params[:id]}"
			end
		else
			redirect '/'
		end
	end

end

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
			flash[:error] = "Make sure to complete the form."
			redirect '/lists/new'
		else
			@topic = Topic.find_or_create_by(name: params[:topic_name])
			@list = List.new(contents: params[:contents], user_id: current_user.id, topic_id: @topic.id)
			@list.save
			flash[:confirm] = "List created!"
			redirect "/lists/#{@list.id}"
		end
	end

	# => read
	get '/lists/:id' do
		if logged_in?
			@list = List.find(params[:id])
			erb :'lists/show'
		else
			flash[:error] = "Please login or signup to view this list."
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

	patch '/lists/:id' do
		if logged_in?
			if params[:contents].any? {|content| content.empty?}
				redirect "/lists/#{params[:id]}/edit"
			else
				@list = List.find(params[:id])
				if @list && @list.user == current_user
					@list.update(contents: params[:contents])
					redirect "/lists/#{@list.id}"
				else
					redirect "/lists/#{params[:id]}"
				end
			end
		else
			redirect '/'
		end
	end

	# => delete
	delete '/lists/:id/delete' do
		if logged_in?
			@list = List.find(params[:id])
			if @list && @list.user == current_user
				@list.delete
			end
			redirect "/users/#{current_user.slug}"
		else
			redirect '/'
		end
	end

end

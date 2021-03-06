class ListsController < ApplicationController

	get '/lists' do
		if logged_in?
			@lists = List.order(created_at: :desc)
			erb :'lists/index'
		else
			redirect '/'
		end
	end

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
			@list = List.create(contents: params[:contents], user_id: current_user.id, topic_id: @topic.id)
			flash[:confirm] = "Top five created!"
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
				flash[:error] = "Make sure to complete the form."
				redirect "/lists/#{params[:id]}/edit"
			else
				@list = List.find(params[:id])
				if @list && @list.user == current_user
					@list.update(contents: params[:contents])
					flash[:confirm] = "Top five updated!"
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
				flash[:confirm] = "Top five deleted."
			end
			redirect '/lists'
		else
			redirect '/'
		end
	end

end

class UsersController < ApplicationController

	# => Login
	post '/login' do
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/topics'
		else
			redirect '/'
		end
	end

	# => Logout
	get '/logout' do
		if logged_in?
			session.clear
			redirect '/'
		else
			redirect '/'
		end
	end

	# => Signup
	get '/signup' do
		if !logged_in?
			erb :'users/signup'
		else
			redirect '/topics'
		end
	end

	post '/signup' do
		if User.find_by(username: params[:username]) || params.values.any? {|v| v.empty?}
			redirect '/signup'
		else
			@user = User.create(params)
			session[:user_id] = @user.id
			redirect '/topics'
		end
	end

	# => read
	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'users/show'
	end

	# => edit
	get '/users/:slug/edit' do
		if logged_in?
			@user = User.find_by_slug(params[:slug])
			if @user && @user == current_user
				@user = User.find_by_slug(params[:slug])
				erb :'/users/edit'
			else
				redirect "/users/#{params[:slug]}"
			end
		else
			redirect '/'
		end
	end

	patch '/users/:slug' do
		if logged_in?
			if params[:name].empty? || params[:username]
				redirect "/users/#{params[:slug]}"
			else
				@user = User.find_by_slug(params[:slug])
				if @user && @user == current_user
					@user.update(name: params[:name], username: params[:username])
					redirect "/users/#{@user.slug}"
				end
				redirect '/topics'
			end
		else
			redirect '/'
		end
	end

	# => destroy
	delete '/users/:slug/delete' do
		if logged_in?
			@user = User.find_by_slug(params[:slug])
			if @user && @user == current_user
				@user.lists.each{ |list| list.destroy }
				@user.destroy
				session.clear
				redirect '/'
			else
				redirect '/topics'
			end
		else
			redirect '/'
		end
	end

end

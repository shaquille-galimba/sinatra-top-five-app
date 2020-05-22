class UsersController < ApplicationController

	# => Login
	post '/login' do
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect "/users/#{@user.slug}"
		else
			flash[:error] = "Your username or password is invalid. Please sign up or try again."
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
		if params.values.any? {|v| v.empty?}
			flash[:error] = "All field in the sign up form must be filled."
			redirect '/signup'
		elsif User.find_by(username: params[:username])
			flash[:error] = "Username already taken."
			redirect '/signup'
		else
			@user = User.create(params)
			session[:user_id] = @user.id
			flash[:confirm] = "Welcome to Top five! Account was successfully created!"
			redirect "/users/#{@user.slug}"
		end
	end

	# => read
	get '/users' do
		@users = User.order(:username)
		erb :'users/index'
	end

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
			if params[:name].empty? || params[:username].empty?
				flash[:error] = "Make sure all fields are filled."
				redirect "/users/#{params[:slug]}/edit"
			else
				@user = User.find_by_slug(params[:slug])
				if @user && @user == current_user
					@user.update(name: params[:name], username: params[:username])
					flash[:confirm] = "Information updated!"
					redirect "/users/#{@user.slug}"
				else
					redirect "/users/#{params[:slug]}"
				end
				redirect "/users/#{@user.slug}"
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

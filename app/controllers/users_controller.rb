class UsersController < ApplicationController

	# => Login
	post '/login' do
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect '/topics'
		else
			redirect '/signup'
		end
	end

	# => Logout
	get '/logout' do
		if logged_in?
			session.clear
			redirect '/login'
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
		if User.find_by(username: params[:username]) || params[:name] == "" || params[:username] == "" || params[:password] == ""
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
		@user = User.find_by_slug(params[:slug])
		erb :'/users/edit'
	end

	patch '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		@user.update(name: params[:name], username: params[:username])
		redirect "users/#{@user.slug}"
	end

	# => destroy
	get '/users/:slug/delete' do
		@user = User.find_by_slug(params[:slug])
		@user.lists.each{ |list| list.destroy }
		@user.destroy
		redirect '/topics'
	end

end

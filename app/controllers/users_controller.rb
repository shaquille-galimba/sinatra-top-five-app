class UsersController < ApplicationController

	# => Login
	post '/login' do
		@user = User.find_by(username: params[:username])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/topics'
		else
			redirect '/'
		end
	end

	# => Signup
	get '/signup' do
		erb :'users/signup'
	end

	post '/signup' do
		if User.find_by(params[:username])
			redirect '/signup'
		else
			@user = User.create(params)
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

end

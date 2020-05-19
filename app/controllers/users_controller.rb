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

end

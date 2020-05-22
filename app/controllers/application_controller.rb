require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "top_five_secrets"
		register Sinatra::Flash
  end

  get "/" do
		if !logged_in?
    	erb :index
		else
			redirect "/users/#{current_user.slug}"
		end
  end

	helpers do
		def logged_in?
			!!current_user
		end

		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end
	end

end

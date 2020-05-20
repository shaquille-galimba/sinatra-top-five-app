class ListsController < ApplicationController

	# => create
	get '/lists/new' do
		erb :'lists/new'
	end

	post '/lists' do
		binding.pry
	end

end

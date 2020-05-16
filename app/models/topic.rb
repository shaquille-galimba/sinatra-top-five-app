class Topic < ActiveRecord::Base
	has_many :lists
	has_many :users, through: :lists
end

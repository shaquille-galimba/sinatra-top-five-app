class Topic < ActiveRecord::Base
	has_many :lists
	has_many :users, through: :lists

	extend Slugifiable::ClassMethods

	def slug
		self.name.gsub(" ", "-").downcase
	end
end

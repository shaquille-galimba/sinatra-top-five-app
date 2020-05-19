class User < ActiveRecord::Base
	has_secure_password

	has_many :lists
	has_many :topics, through: :lists

	extend Slugifiable::ClassMethods

	def slug
		self.username.gsub(" ", "-").downcase
	end
end

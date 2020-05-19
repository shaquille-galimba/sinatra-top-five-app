class List < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic

	def parse
		self.contents.gsub("[", "").gsub("]", "").split(",")
	end
end

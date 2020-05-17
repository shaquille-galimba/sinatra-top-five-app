class List < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic

	def parse_list
		arr = []
		self.contents.gsub("[", "").gsub("]", "").split(",").each {|c| arr << c}
		arr
	end
end

class List < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic

	def arrayed_contents
		self.contents.scan(/\"(.*?)\"/).flatten
	end
end

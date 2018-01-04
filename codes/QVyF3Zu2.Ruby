module Ownership
	def self.belongings(user)
		self.where :user_id => user_id	
	end
end
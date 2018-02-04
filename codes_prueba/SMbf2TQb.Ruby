module Ownership
	def self.belongings(user)
		self.where :user_id => user.id	
	end
end
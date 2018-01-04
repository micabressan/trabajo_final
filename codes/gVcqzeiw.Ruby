module Ownership
	def self.belongings(user)
		self.where :user_id => current_user.id	
	end
end
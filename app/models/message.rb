class Message < ApplicationRecord
	belongs_to :user

	def self.filter(filter,user_id)
		if filter == "Sent Mail"
			where('recipient_id like ?' , '%#{user_id}%')
		else
			where('user_id like ?', '%#{user_id}%')
		end
	end
end

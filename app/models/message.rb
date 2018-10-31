class Message < ApplicationRecord
	belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  	belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

end

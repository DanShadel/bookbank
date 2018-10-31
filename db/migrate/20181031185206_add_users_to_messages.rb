class AddUsersToMessages < ActiveRecord::Migration[5.1]
  def change
  	remove_column :messages, :user_id
  	add_column :messages, :owner_id, :integer
  end
end

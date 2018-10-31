class RemoveOwnerFromMessage < ActiveRecord::Migration[5.1]
  def change
    	remove_column :messages, :owner_id
  end
end

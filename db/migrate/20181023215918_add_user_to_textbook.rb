class AddUserToTextbook < ActiveRecord::Migration[5.1]
  def change
  	add_column :textbooks, :user_id, :integer
  end
end

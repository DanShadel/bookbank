class AddParentToMessages < ActiveRecord::Migration[5.1]
  def change
  	add_column :messages, :parent_id, :integer
  end
end

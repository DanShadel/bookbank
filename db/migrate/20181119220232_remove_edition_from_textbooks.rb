class RemoveEditionFromTextbooks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :messages, :edition
  end
end

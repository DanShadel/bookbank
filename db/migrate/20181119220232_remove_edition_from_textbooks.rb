class RemoveEditionFromTextbooks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :textbooks, :edition
  end
end

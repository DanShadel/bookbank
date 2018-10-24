class RemoveEmailFromTextbooks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :textbooks, :email
  end
end

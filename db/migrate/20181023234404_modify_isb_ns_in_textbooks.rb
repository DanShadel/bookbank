class ModifyIsbNsInTextbooks < ActiveRecord::Migration[5.1]
  def change

  	add_column :textbooks, :isbn_10, :string
  	add_column :textbooks, :isbn_13, :string
  	remove_column :textbooks, :isbn

  end
end

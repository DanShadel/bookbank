class MergeIsbnNumbers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :textbooks, :isbn_10
  	remove_column :textbooks, :isbn_13
  	add_column :textbooks, :isbn, :string
  end
end

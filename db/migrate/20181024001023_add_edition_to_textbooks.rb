class AddEditionToTextbooks < ActiveRecord::Migration[5.1]
  def change
 	add_column :textbooks, :edition, :string
 	add_column :textbooks, :section, :string 	
  end
end

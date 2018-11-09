class AddImages < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :image, :string
  	add_column :textbooks, :image, :string
  end
end

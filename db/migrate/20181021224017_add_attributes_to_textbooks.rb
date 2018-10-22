class AddAttributesToTextbooks < ActiveRecord::Migration[5.1]
  def change

  	add_column :textbooks, :price, :decimal
  	add_column :textbooks, :description, :text
  	add_column :textbooks, :author, :string
  	add_column :textbooks, :location, :string
  	add_column :textbooks, :amount_used, :string

  end
end

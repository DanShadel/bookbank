class AddEmailToTextbooks < ActiveRecord::Migration[5.1]
  def change
  	add_column :textbooks, :email, :string
  end
end

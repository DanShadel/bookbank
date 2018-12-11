class AddAmazonToTextbooks < ActiveRecord::Migration[5.1]
  def change
    add_column :textbooks, :amazon, :integer
  end
end

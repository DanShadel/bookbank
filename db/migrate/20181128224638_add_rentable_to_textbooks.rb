class AddRentableToTextbooks < ActiveRecord::Migration[5.1]
  def change
    add_column :textbooks, :rentable, :boolean
  end
end

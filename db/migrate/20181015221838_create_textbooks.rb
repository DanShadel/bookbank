class CreateTextbooks < ActiveRecord::Migration[5.1]
  def change
    create_table :textbooks do |t|
      t.string :title
      t.string :condition
      t.string :isbn

      t.timestamps
    end
  end
end

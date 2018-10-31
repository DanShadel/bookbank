class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.integer :owner_id
      t.integer :recipient_id
      t.boolean :read

      t.timestamps
    end
  end
end

class AddSubjectToTextbook < ActiveRecord::Migration[5.1]
  def change
    add_column :textbooks, :subject, :string
  end
end

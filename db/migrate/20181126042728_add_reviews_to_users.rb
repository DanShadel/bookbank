class AddReviewsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :score, :real, :default => 0
    add_column :users, :num_reviews, :integer, :default => 0
  end
end

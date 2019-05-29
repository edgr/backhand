class AddReviewScoreToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :review_score, :integer
  end
end

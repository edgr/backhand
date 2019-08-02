class AddMatchToUserReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_reviews, :match, foreign_key: true
  end
end

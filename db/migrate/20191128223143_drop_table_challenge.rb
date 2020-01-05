class DropTableChallenge < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :challenges, :users
    remove_column :user_reviews, :challenge_id, :bigint
    drop_table :challenges
  end
end

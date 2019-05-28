class CreateUserReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reviews do |t|
      t.references :sender
      t.references :receiver
      t.references :challenge
      t.integer :serve
      t.integer :return
      t.integer :backhand
      t.integer :volley
      t.integer :speed
      t.integer :power
      t.integer :endurance
      t.boolean :thumb
      t.integer :forehand
      t.text :content

      t.timestamps
    end
    add_foreign_key :user_reviews, :users, column: :sender_id
    add_foreign_key :user_reviews, :users, column: :receiver_id
    add_foreign_key :user_reviews, :challenges, column: :challenge_id
  end
end

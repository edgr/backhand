class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :player
      t.references :opponent
      t.date :date
      t.string :location
      t.string :score
      t.string :winner
      t.string :loser

      t.timestamps
    end
    add_foreign_key :matches, :users, column: :player_id
    add_foreign_key :matches, :users, column: :opponent_id
  end
end

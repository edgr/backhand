class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.references :challenger
      t.references :challengee
      t.string :score
      t.string :winner
      t.string :loser
      t.string :location
      t.string :status
      t.string :proposed_time_slots
      t.date :date

      t.timestamps
    end

    add_foreign_key :challenges, :users, column: :challenger_id
    add_foreign_key :challenges, :users, column: :challengee_id
  end
end

class CreateMatchResults < ActiveRecord::Migration[5.2]
  def change
    create_table :match_results do |t|
      t.references :match
      t.references :winner
      t.references :loser
      t.string :score
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_foreign_key :match_results, :matches, column: :match_id
    add_foreign_key :match_results, :users, column: :winner_id
    add_foreign_key :match_results, :users, column: :loser_id
  end
end

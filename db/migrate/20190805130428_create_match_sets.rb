class CreateMatchSets < ActiveRecord::Migration[5.2]
  def change
    create_table :match_sets do |t|
      t.references :match, foreign_key: true
      t.integer :player_1_games
      t.integer :player_2_games

      t.timestamps
    end
  end
end

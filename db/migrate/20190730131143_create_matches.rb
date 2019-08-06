class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.references :player_1
      t.references :player_2
      t.date :date
      t.references :club

      t.timestamps
    end
    add_foreign_key :matches, :users, column: :player_1_id
    add_foreign_key :matches, :users, column: :player_2_id
    add_foreign_key :matches, :clubs, column: :club_id
  end
end

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :player_1
      t.references :player_2
      t.references :player_3
      t.references :player_4
      t.date :date_time
      t.references :club
      t.integer :event_duration

      t.timestamps
    end
    add_foreign_key :events, :users, column: :player_1_id
    add_foreign_key :events, :users, column: :player_2_id
    add_foreign_key :events, :users, column: :player_3_id
    add_foreign_key :events, :users, column: :player_4_id
    add_foreign_key :events, :clubs, column: :club_id
  end
end

class CreateShoutouts < ActiveRecord::Migration[5.2]
  def change
    create_table :shoutouts do |t|
      t.boolean :recipients
      t.integer :minimum_level
      t.string :message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

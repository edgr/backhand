class CreateUserTags < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tags do |t|
      t.references :users, foreign_key: true
      t.references :tags, foreign_key: true

      t.timestamps
    end
  end
end

class DropUserTags < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:user_tags, :users)
      remove_foreign_key :user_tags, :users
    end
    drop_table :user_tags
  end
end

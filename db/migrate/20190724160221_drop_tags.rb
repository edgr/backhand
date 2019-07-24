class DropTags < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:user_tags, :tags)
      remove_foreign_key :user_tags, :tags
    end
    drop_table :tags
  end
end

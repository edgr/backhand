class DropUserTags < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_tags
  end
end

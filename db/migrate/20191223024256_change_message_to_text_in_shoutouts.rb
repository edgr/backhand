class ChangeMessageToTextInShoutouts < ActiveRecord::Migration[5.2]
  def change
    change_column :shoutouts, :message, :text
  end
end

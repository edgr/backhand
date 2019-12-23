class ChangeRecipientsToTextInShoutouts < ActiveRecord::Migration[5.2]
  def change
    change_column :shoutouts, :recipients, :text
  end
end

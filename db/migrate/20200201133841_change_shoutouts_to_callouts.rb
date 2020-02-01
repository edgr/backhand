class ChangeShoutoutsToCallouts < ActiveRecord::Migration[5.2]
  def change
    rename_table :shoutouts, :callouts
  end
end

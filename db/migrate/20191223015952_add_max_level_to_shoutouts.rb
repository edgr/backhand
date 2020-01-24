class AddMaxLevelToShoutouts < ActiveRecord::Migration[5.2]
  def change
    add_column :shoutouts, :maximum_level, :integer
  end
end

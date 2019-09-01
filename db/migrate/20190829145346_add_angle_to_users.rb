class AddAngleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :angle, :integer, default: 0
  end
end

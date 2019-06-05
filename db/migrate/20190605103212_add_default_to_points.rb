class AddDefaultToPoints < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :points, :float, default: 1200
  end
end

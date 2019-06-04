class ChangeLatLngTypeToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :latitude, :float
    change_column :users, :longitude, :float
  end
end

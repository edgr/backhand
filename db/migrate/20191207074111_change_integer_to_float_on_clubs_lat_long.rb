class ChangeIntegerToFloatOnClubsLatLong < ActiveRecord::Migration[5.2]
  def change
    change_column :clubs, :latitude, :float
    change_column :clubs, :longitude, :float
  end
end

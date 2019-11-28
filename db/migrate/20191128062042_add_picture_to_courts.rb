class AddPictureToCourts < ActiveRecord::Migration[5.2]
  def change
    add_column :courts, :picture, :string
  end
end

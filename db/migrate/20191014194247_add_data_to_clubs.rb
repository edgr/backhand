class AddDataToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :address, :string
    add_column :clubs, :email, :string
    add_column :clubs, :phone_number, :string
    add_column :clubs, :description, :text
    add_column :clubs, :website, :string
    add_column :clubs, :picture, :string
    add_column :clubs, :latitude, :integer
    add_column :clubs, :longitude, :integer
  end
end

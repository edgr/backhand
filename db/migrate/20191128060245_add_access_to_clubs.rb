class AddAccessToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :access, :string
  end
end

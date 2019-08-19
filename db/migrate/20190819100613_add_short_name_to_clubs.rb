class AddShortNameToClubs < ActiveRecord::Migration[5.2]
  def change
    add_column :clubs, :shortname, :string
  end
end

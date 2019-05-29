class ChangeColumnInUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :nationality, :country
  end
end

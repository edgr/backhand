class AddStatusToCallouts < ActiveRecord::Migration[5.2]
  def change
    add_column :callouts, :status, :string
  end
end

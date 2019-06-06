class ChangeWinnerLoserTypeToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :winner
    remove_column :challenges, :loser
    add_column :challenges, :winner, :integer
    add_column :challenges, :loser, :integer
  end
end

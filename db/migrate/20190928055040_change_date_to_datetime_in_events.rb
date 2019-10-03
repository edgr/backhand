class ChangeDateToDatetimeInEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :date_time, :datetime
  end
end

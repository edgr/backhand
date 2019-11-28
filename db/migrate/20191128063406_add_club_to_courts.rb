class AddClubToCourts < ActiveRecord::Migration[5.2]
  def change
    add_reference :courts, :club, foreign_key: true
  end
end

class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :level, :string
    add_column :users, :bio, :text
    add_column :users, :address, :string
    add_column :users, :place_of_birth, :string
    add_column :users, :user_name, :string
    add_column :users, :style_of_play, :string
    add_column :users, :gender, :string
    add_column :users, :nationality, :string
    add_column :users, :picture, :string
    add_column :users, :elo_ranking, :integer
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :latitude, :integer
    add_column :users, :longitude, :integer
    add_column :users, :birthday, :date
    add_column :users, :total_points, :integer
  end
end

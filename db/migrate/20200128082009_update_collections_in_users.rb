class UpdateCollectionsInUsers < ActiveRecord::Migration[5.2]
  def change
    User.active.each do |user|
      user.gender = user.gender.downcase
      user.handedness = user.handedness.downcase
      user.backhand_style = user.backhand_style.gsub(' ', '_')
      user.save!
    end
  end
end

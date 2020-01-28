class UpdateCollectionsInUsers < ActiveRecord::Migration[5.2]
  def change
    User.active.each do |user|
      user.gender = user.gender.downcase
      user.handedness = user.handedness.downcase
      user.backhand_style = user.backhand_style.gsub(' ', '_')
      if user.level == "Semi-pro +"
        user.level = user.level.gsub('-', '_').gsub(' +', '_plus').downcase
      elsif user.level == "Semi-pro"
        user.level = user.level.gsub('-', '_').downcase
      else
        user.level = user.level.gsub(' +', '_plus').downcase
      end
      if user.style_of_play == "server-volleyer"
        user.style_of_play = "server_volleyer"
      end
      user.save!
    end
  end
end

class ChangeLevelsAndStylesInUsers < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |user|
      if user.level == "Semi-pro +"
        user.level = user.level.gsub('-', '_').gsub(' +', '_plus').downcase
        puts user.level
      elsif user.level == "Semi-pro"
        user.level = user.level.gsub('-', '_').downcase
        puts user.level
      else
        user.level = user.level.gsub(' +', '_plus').downcase
        puts user.level
      end
      if user.style_of_play == "server-volleyer"
        user.style_of_play = "server_volleyer"
      end
      user.save!
    end
  end
end

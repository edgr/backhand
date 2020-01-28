class ChangeLevelsAndStylesInUsers < ActiveRecord::Migration[5.2]
  def change
    sv_players = User.where(style_of_play: "server-volleyer")
    sv_players.each do |player|
      player.style_of_play = "server_volleyer"
      player.save!
    end

    spp_players = User.where(level: "Semi-pro +")
    spp_players.each do |player|
      player.level = player.level.gsub('-', '_').gsub(' +', '_plus').downcase
      player.save!
    end

    sp_players = User.where(level: "Semi-pro")
    sp_players.each do |player|
      player.level = player.level.gsub('-', '_').downcase
      player.save!
    end

    User.all.each do |user|
      user.level = user.level.gsub(' +', '_plus').downcase
      user.save!
    end
  end
end

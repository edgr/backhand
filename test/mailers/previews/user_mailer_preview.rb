# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    @user = User.first

    UserMailer.with(user: @user).welcome
  end

  def new_game
    @inviter = User.find(273)
    @partner = User.find(274)
    @event = Event.first

    UserMailer.with(
      inviter: @inviter,
      partner: @partner,
      event: @event
    ).new_game.deliver_now
  end

  def new_player_review
    @sender = User.find(273)
    @receiver = User.find(274)
    @user_review = UserReview.first

    UserMailer.with(
      sender: @sender,
      receiver: @receiver,
      user_review: @user_review
    ).new_player_review.deliver_now
  end

  def new_match_result
    @player_1 = User.find(273)
    @player_2 = User.find(274)
    @match = Match.first

    UserMailer.with(
      player_1: @player_1,
      player_2: @player_2,
      match: @match
    ).new_match_result.deliver_now
  end

end

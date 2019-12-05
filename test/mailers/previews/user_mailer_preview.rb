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

end

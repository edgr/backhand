# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.first

    UserMailer.with(user: user).welcome
  end

  def new_game
    inviter = User.first
    partner = User.last
    event = Event.first

    UserMailer.with(
      inviter: inviter,
      partner: partner,
      event: event
    ).new_game.deliver_now
  end

end

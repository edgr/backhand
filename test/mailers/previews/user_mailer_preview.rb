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

    self.template_model = {
      inviter_first_name: inviter.first_name,
      partner_first_name: partner.first_name,
      date: event.date_time.strftime("%A %b %e"),
      time: event.date_time.strftime("%l:%M%p"),
      location: event.club.name
    }
    # mail to: partner.email

    # UserMailer.with(user: user).welcome
    UserMailer.with(inviter: inviter, partner: partner, event: event).new_game.deliver_now

  end

end

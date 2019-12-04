require 'postmark-rails/templated_mailer'

class UserMailer < ApplicationMailer
  include PostmarkRails::TemplatedMailerMixin
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #

  def welcome
    user = params[:user]
    mail(
      to: user.email,
      bcc: 'edouard@backhandapp.com'
    )
  end

  def new_game
    inviter = params[:inviter]
    partner = params[:partner]
    event = params[:event]
    self.template_model = {
      inviter_first_name: inviter.first_name,
      partner_first_name: partner.first_name,
      date: event.date_time.strftime("%A %b %e"),
      time: event.date_time.strftime("%l:%M%p"),
      location: event.club.name
    }
    mail to: partner.email
  end
end

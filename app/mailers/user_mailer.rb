require 'postmark-rails/templated_mailer'

class UserMailer < ApplicationMailer
  include PostmarkRails::TemplatedMailerMixin
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #

  def welcome
    @user = params[:user]
    mail(
      to: @user.email,
      bcc: 'edouard@backhandapp.com'
    )
  end

  def new_game
    @inviter = params[:inviter]
    @partner = params[:partner]
    @event = params[:event]
    self.template_model = {
      inviter_first_name: @inviter.first_name,
      partner_first_name: @partner.first_name,
      date: @event.date_time.strftime("%A %b %e"),
      time: @event.date_time.strftime("%l:%M%p"),
      location: @event.club.name
    }
    mail to: @partner.email
  end

  def new_player_review
    @sender = params[:sender]
    @receiver = params[:receiver]
    @user_review = params[:user_review]
    @url = sender_url(@sender.id)
    self.template_model = {
      sender_first_name: @sender.first_name,
      receiver_first_name: @receiver.first_name,
      user_review_content: @user_review.content,
      sender_url: @url
    }
    mail to: @receiver.email
  end

  def new_match_result
    @player_1 = params[:player_1]
    @player_2 = params[:player_2]
    @match = params[:match]
    winner = User.find(@match.match_result.winner_id)
    @winner = winner_name_in_email(winner)
    self.template_model = {
      player_1_first_name: @player_1.first_name,
      player_2_first_name: @player_2.first_name,
      match_result: @match.match_result.score,
      winner: @winner
    }
    mail to: @player_2.email
  end

  private

  def sender_url(id)
    "https://www.backhandapp.com/users/#{id}/user_reviews/new"
  end

  def winner_name_in_email(winner)
    if winner == @player_2
      "You"
    else
      @player_1.first_name
    end
  end
end

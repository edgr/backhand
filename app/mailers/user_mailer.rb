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
    self.template_model = {
      player_first_name: @user.first_name
    }
    mail(
      to: @user.email,
      bcc: 'edouard@backhandapp.com'
    )
  end

  def new_game_event
    @inviter = params[:inviter]
    @partner = params[:partner]
    @event = params[:event]
    I18n.locale = @partner.language
    self.template_model = {
      "#{@partner.language}": true,
      subject: I18n.t('.new_event_email_subject', inviter: @inviter.first_name),
      inviter_first_name: @inviter.first_name,
      partner_first_name: @partner.first_name,
      date: I18n.t('.event_date', event_date: (l @event.date_time.to_date, format: :medium)),
      time: I18n.t('.event_time', event_time: (l @event.date_time, format: :very_short)),
      location: @event.club.name
    }
    mail to: @partner.email
  end

  def new_player_review
    @sender = params[:sender]
    @receiver = params[:receiver]
    @user_review = params[:user_review]
    @url = sender_url(@sender.id)
    I18n.locale = @receiver.language
    self.template_model = {
      "#{@receiver.language}": true,
      subject: I18n.t('.new_player_review_email_subject', sender: @sender.first_name),
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
    I18n.locale = @player_2.language
    self.template_model = {
      "#{@player_2.language}": true,
      subject: I18n.t('.new_match_result_email_subject', sender: @player_1.first_name),
      player_1_first_name: @player_1.first_name,
      player_2_first_name: @player_2.first_name,
      match_result: @match.match_result.score,
      winner: @winner
    }
    mail to: @player_2.email
  end

  def confirmed_match_result
    @player_1 = params[:player_1]
    @player_2 = params[:player_2]
    @match_result = params[:match_result]
    I18n.locale = @player_1.language
    self.template_model = {
      "#{@player_1.language}": true,
      subject: I18n.t('.new_confirmed_match_result_email_subject', sender: @player_1.first_name),
      player_1_first_name: @player_1.first_name,
      player_2_first_name: @player_2.first_name,
      match_result: @match_result.score
    }
    mail to: @player_1.email
  end

  def new_callout
    @inviter = params[:inviter]
    @recipient = params[:recipient]
    @callout = params[:callout]
    I18n.locale = @recipient.language
    self.template_model = {
      "#{@recipient.language}": true,
      subject: I18n.t('.new_callout_email_subject', sender: @inviter.first_name),
      inviter_first_name: @inviter.first_name,
      inviter_points: @inviter.points.truncate(2),
      inviter_ranking: @inviter.ranking,
      recipient_first_name: @recipient.first_name,
      callout: @callout.message
    }
    mail to: @recipient.email
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

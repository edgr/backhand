# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    @user = User.first

    UserMailer.with(user: @user).welcome
  end

  def new_game_event
    @inviter = User.first
    @partner = User.last
    @event = Event.first

    UserMailer.with(
      inviter: @inviter,
      partner: @partner,
      event: @event
    ).new_game_event.deliver_now unless @partner.settings[:new_game_event] == false
  end

  def new_player_review
    @sender = User.first
    @receiver = User.last
    @user_review = UserReview.first

    UserMailer.with(
      sender: @sender,
      receiver: @receiver,
      user_review: @user_review
    ).new_player_review.deliver_now unless @receiver.settings[:new_player_review_email] == false
  end

  def new_match_result
    @player_1 = User.first
    @player_2 = User.last
    @match = Match.first

    UserMailer.with(
      player_1: @player_1,
      player_2: @player_2,
      match: @match
    ).new_match_result.deliver_now unless @player_2.settings[:new_match_result_email] == false
  end

  def confirmed_match_result
    @player_1 = User.first
    @player_2 = User.last
    @match = Match.first

    UserMailer.with(
      player_1: @player_1,
      player_2: @player_2,
      match: @match
    ).confirmed_match_result.deliver_now unless @player_2.settings[:confirmed_match_result_email] == false
  end

  def new_callout
    @inviter = User.first
    @recipient = User.last
    @callout = Callout.first

    self.template_model = {
      inviter_first_name: @inviter.first_name,
      inviter_points: @inviter.points,
      recipient_first_name: @recipient.first_name,
      callout: @callout.message
    }.new_callout.deliver_now unless @recipient.settings[:new_callout_email] == false
  end

end

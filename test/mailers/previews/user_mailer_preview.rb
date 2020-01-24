# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    @user = User.first

    UserMailer.with(user: @user).welcome
  end

  def new_game_event
    @inviter = User.find(273)
    @partner = User.find(274)
    @event = Event.first

    UserMailer.with(
      inviter: @inviter,
      partner: @partner,
      event: @event
    ).new_game_event.deliver_now unless @partner.settings[:new_game_event] == false
  end

  def new_player_review
    @sender = User.find(273)
    @receiver = User.find(274)
    @user_review = UserReview.first

    UserMailer.with(
      sender: @sender,
      receiver: @receiver,
      user_review: @user_review
    ).new_player_review.deliver_now unless @receiver.settings[:new_player_review_email] == false
  end

  def new_match_result
    @player_1 = User.find(273)
    @player_2 = User.find(274)
    @match = Match.first

    UserMailer.with(
      player_1: @player_1,
      player_2: @player_2,
      match: @match
    ).new_match_result.deliver_now unless @player_2.settings[:new_match_result_email] == false
  end

  def confirmed_match_result
    @player_1 = User.find(273)
    @player_2 = User.find(274)
    @match = Match.first

    UserMailer.with(
      player_1: @player_1,
      player_2: @player_2,
      match: @match
    ).confirmed_match_result.deliver_now unless @player_2.settings[:confirmed_match_result_email] == false
  end

end

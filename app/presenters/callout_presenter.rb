class CalloutPresenter < BasePresenter
  presents :callout

  def created_at
    seconds = (Time.now - callout.created_at)
    if seconds < 60
      I18n.t('.seconds_ago', seconds: seconds.to_i)
    elsif seconds < 3600
      minutes = seconds / 60
      I18n.t('.minutes_ago', minutes: minutes.to_i)
    else
      hours = seconds / 3600
      I18n.t('.hours_ago', hours: hours.to_i)
    end
  end
end

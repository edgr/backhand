class CalloutPresenter < BasePresenter
  presents :callout

  def created_at
    seconds = (Time.now - callout.created_at)
    if seconds < 60
      "#{seconds.to_i}s ago"
    elsif seconds < 3600
      minutes = seconds / 60
      "#{minutes.to_i}m ago"
    else
      hours = seconds / 3600
      "#{hours.to_i}h ago"
    end
  end
end

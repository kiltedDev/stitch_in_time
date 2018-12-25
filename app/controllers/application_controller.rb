class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  around_action :set_time_zone,     if: :current_user
  before_action :authenticate_user!

  private

  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end


  def pretty_time(time)
    hours = (time/60/60).floor.to_s
    minutes = (time / (60) % 60).to_s
    seconds = (time % 60).to_s
    if hours.length < 2
      hours = "0" + hours
    end

    if minutes.length < 2
      minutes = "0" + minutes
    end

    if seconds.length < 2
      seconds = "0" + seconds
    end

    "#{hours}:#{minutes}:#{seconds}"
  end
end

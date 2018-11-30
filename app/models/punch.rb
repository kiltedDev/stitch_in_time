class Punch < ApplicationRecord
  require 'hublot'
  belongs_to :project
  delegate :user, to: :project
  validates :time_in, presence: true
  default_scope -> { order(time_in: :desc) }


  def marker
    if self.comment?
      self.comment
    else
      self.time_in.pretty
    end
  end

  def active?
    self.time_out.nil?
  end

  def adjust_time
    self.time_worked = self.time_out - self.time_in
    self.save
  end

  def pretty_time
    hours = (self.time_worked/60/60).floor
    minutes = self.time_worked / (60) % 60
    "#{hours} hours and #{minutes} minutes"
  end
end

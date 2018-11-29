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
end

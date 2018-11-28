class Punch < ApplicationRecord
  belongs_to :project
  delegate :user, to: :project
  validates :time_in, presence: true
end

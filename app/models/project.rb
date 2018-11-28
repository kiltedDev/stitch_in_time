class Project < ApplicationRecord
  belongs_to :user
  has_many :punches, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :description, presence: true
end

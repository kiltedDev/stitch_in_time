class Project < ApplicationRecord
  belongs_to :user
  has_many :punches, dependent: :destroy
  default_scope -> { order(last_punch: :desc) }
  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :description, presence: true

  # Checks the punch card for the most recent punch.
  # Not altering if there are no punches.
  def check_card
    if self.punches.first
      self.last_punch = self.punches.first.time_out || self.punches.first.time_in
      self.save
    end
  end

  def tally_cards
    sum = 0
    self.punches.each do |c|
      sum += c.time_worked
    end
    self.update(time_worked: sum)
  end

  def to_csv
    attributes = %w{id time_in time_out comment}

    ::CSV.generate(headers: true) do |csv|
      csv << attributes

      self.punches.each do |punch|
        csv << attributes.map{ |attr| punch.send(attr) }
      end
    end
  end
end

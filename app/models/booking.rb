class Booking < ApplicationRecord
  STATUS = ["pending", "declined", "accepted"]

  belongs_to :user
  belongs_to :pet

  validates :status, inclusion: { in: STATUS }
  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }
end

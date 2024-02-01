class Booking < ApplicationRecord
  STATUS = ["pending", "declined", "accepted"]

  belongs_to :user
  belongs_to :pet

  validates :status, inclusion: { in: STATUS }
  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }

  # validate :end_date_after_start_date

  # private

  # def end_date_after_start_date

  #   if end_date < start_date
  #     errors.add(:end_date, "must be greater than the start date")
  #   end
  # end
end

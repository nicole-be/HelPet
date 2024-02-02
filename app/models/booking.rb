class Booking < ApplicationRecord
  STATUS = ["pending", "declined", "accepted"]

  belongs_to :user
  belongs_to :pet

  validates :status, inclusion: { in: STATUS }
  validates :start_date, presence: true
  validates :end_date, comparison: { greater_than_or_equal_to: :start_date }

  def total_price
    (((end_date - start_date + 1).to_i) * pet.price).truncate
  end

  def total_days
    ((end_date - start_date + 1).to_i)
  end
end

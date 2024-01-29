class Booking < ApplicationRecord
  STATUS = ["pending", "declined", "accepted"]

  belongs_to :user
  belongs_to :pet

  validates :status, inclusion: { in: STATUS }
end

class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  validates :name, presence: true, length: { minimum: 2 }
  validates :species, presence: true # nice to have: a fixed list to choose from (dropdown or something)
  #validates :breed, presence: true #TBD later on with the API
  validates :description, presence: true, length: { minimum: 150 }
end

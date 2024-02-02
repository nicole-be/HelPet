class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many_attached :photos

  SPECIES = ["cat", "dog", "horse"]

  validates :name, presence: true, length: { minimum: 2 }
  validates :species, presence: true,  inclusion: { in: SPECIES } # nice to have: a fixed list to choose from (dropdown or something)
  #validates :breed, presence: true #TBD later on with the API
  # disabled the description validator, because testing is easier then
  # validates :description, presence: true, length: { minimum: 150 }
  validates :price, presence: true, numericality: { minimum: 1.0 }

  # search for a pet
  include PgSearch::Model

  pg_search_scope :global_search,
    against: [ :name, :species, :breed, :description ],
    associated_against: {
      user: [ :first_name, :last_name, :address, :description ]
    },
    using: {
      tsearch: { prefix: true }
    }
end

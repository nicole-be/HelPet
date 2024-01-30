class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLE = ["owner", "client"]

  has_many :pets
  has_many :bookings
  has_one_attached :photo

  # validates :email, presence: true
  # validates :password
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  # we don't need the role, as it causes problems when creating a new user -> default?
  # validates :role, inclusion: { in: ROLE }
  validates :address, presence: true
end

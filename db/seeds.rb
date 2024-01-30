# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(first_name: "Anna", last_name: "Mueller", email: "user@example.com", password: "password", address: "london", role:"owner")
Pet.create!(species: "Dog", description: "A loyal and friendly companion", name: "Buddy", user: user)
Pet.create!(species: "Cat", description: "An independent and playful pet", name: "Whiskers", user: user)
Pet.create!(species: "Bird", description: "A colorful and chirpy friend", name: "Sunny", user: user)

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Pet.destroy_all
Booking.destroy_all
User.destroy_all

puts "Starting to seed..."

users = []

8.times {
  @user = User.new(
    email: "test#{('a'..'z').to_a.sample*rand(1..5)}@example.com",
    password: 'password',
    password_confirmation:'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.city # changed to city, because of the map later on
    )

    if @user.save
      users << @user
    else
      @user.errors.messages
    end
}

puts "Users created!"

pet_call = {
  dog: Faker::Creature::Dog.breed,
  cat: Faker::Creature::Cat.breed,
  horse: Faker::Creature::Horse.breed
}

pets = []

12.times {
  species = pet_call.keys.sample
  @pet = Pet.new(
    name: Faker::Name.name,
    species: species.to_s,
    breed: pet_call[species],
    description: Faker::Lorem.paragraph_by_chars(number: 150),
    user: users.sample
  )

  if @pet.save
    pets << @pet
  else
    @pet.errors.messages
  end
}

puts "Pets created!"

10.times {
  @booking = Booking.new(
    start_date: Faker::Date.between(from: '2023-01-01', to: Date.today),
    end_date: Faker::Date.between(from: '2023-01-01', to: Date.today),
    status: ["pending", "declined", "accepted"].sample,
    pet: pets.sample,
    user: users.sample
  )

  @pet.errors.messages unless @booking.save
}

puts "Bookings created!"

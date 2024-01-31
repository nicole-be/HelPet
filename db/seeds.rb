# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# File.open(Rails.root.join('db/images/NAME_OF_YOUR_FILE.jpeg')

puts "Cleaning database..."
Booking.destroy_all
Pet.destroy_all
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

descriptions = {
  cat: "This cat is the epitome of feline grace and charm. With fur as soft as moonlight, a cuddly companion who purrs melodies of joy, casting a spell of warmth and love with every gentle nuzzle. A true embodiment of feline enchantment!",
  dog: "This canine comedian with a tail-wagging sense of humor! From goofy antics to hilarious expressions, a four-legged stand-up sensation, spreading laughter and joy with every playful bounce. Get ready for a daily dose of belly laughs and wagging tails with this lovable goofball!",
  horse: "The majestic equine beauty that embodies grace and strength in every hoofbeat. With a coat that shimmers like sunlight on a tranquil meadow, a gentle giant with a heart as vast as the open fields. Riding into the sunset with this magnificent creature is a journey of pure elegance and companionship."
}

names = {
  cat: "Mr. Whiskers",
  dog: "Buddy",
  horse: "Spirit"
}

12.times {
  species = pet_call.keys.sample
  @pet = Pet.new(
    name: names[species],
    species: species.to_s,
    breed: pet_call[species],
    description: descriptions[species],
    user: users.sample
  )

  if @pet.save
    @pet.photos.attach(io: File.open(Rails.root.join("app/assets/images/#{@pet.species}.jpg")), filename: "#{@pet.species}.jpg")
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

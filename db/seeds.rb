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

user = {
  address: ["Goethestraße, Frankfurt am Main", "Kurfürstendamm, Berlin", "Ludwigstraße, München", "Hohe Bleichen, Hamburg", "Potsdamer Platz, Berlin", "Kaiser-Wilhelm-Ring, Köln", "Schadowstraße, Düsseldorf", "Willy-Brandt-Straße, Hamburg", "Augustusplatz, Leipzig", "Friedrichstraße, Berlin"],
  ctr: 0
}

8.times {
  @user = User.new(
    email: "test#{('a'..'z').to_a.sample*rand(1..5)}@example.com",
    password: 'password',
    password_confirmation:'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: user[:address].sample # changed to city, because of the map later on
    )

    myuser = "avatar#{user[:ctr] % 4}"

    if @user.save
      @user.photo.attach(io: File.open(Rails.root.join("app/assets/images/#{myuser}.jpeg")), filename: "#{myuser}.jpeg")
      user[:ctr] += 1
      users << @user
    else
      puts @user.errors.messages
    end
}

puts "Users created!"

pets = []

pet = {
  cat: {
    call: Faker::Creature::Cat.breed,
    name: ["Mr. Whiskers", "Oliver", "Chloe", "Simba", "Luna", "Jasper", "Mia", "Gizmo", "Cleo", "Oscar", "Nala"],
    description: "This cat is the epitome of feline grace and charm.",
    ctr: 0
  },
  dog: {
    call: Faker::Creature::Dog.breed,
    name: ["Buddy", "Bella", "Max", "Luna", "Rocky", "Daisy", "Charlie", "Sadie", "Toby", "Zoey", "Cooper"],
    description: "This canine comedian with a tail-wagging sense of humor!",
    ctr: 0
  },
  horse: {
    call: Faker::Creature::Horse.breed,
    name: ["Spirit", "Thunder", "Spirit", "Bella Rosa", "Maverick", "Starlight", "Dakota", "Serenity", "Apollo 13", "Willow Wind", "Midnight Majesty"],
    description: "The majestic equine beauty that embodies grace and strength in every hoofbeat.",
    ctr: 0
  }
}

12.times {
  species = pet.keys.sample
  @pet = Pet.new(
    name: pet[species][:name].sample,
    species: species.to_s,
    breed: pet[species][:call],
    description: pet[species][:description],
    price: rand(1.0 .. 999.0).round(2),
    user: users.sample
  )

  mypet = "#{@pet.species}#{pet[species][:ctr] % 4}"

  if @pet.save
    @pet.photos.attach(io: File.open(Rails.root.join("app/assets/images/#{mypet}.jpg")), filename: "#{mypet}.jpg")
    pet[species][:ctr] += 1
    pets << @pet
  else
    puts @pet.errors.messages
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

  puts @pet.errors.messages unless @booking.save
}

puts "Bookings created!"

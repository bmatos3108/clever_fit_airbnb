# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Removing all instances
Review.destroy_all
Booking.destroy_all
Service.destroy_all
User.destroy_all

# My Creation of Instances

30.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

puts "Users created"

users = User.all

# Create Services
150.times do
  Service.create!(
    name: Faker::Food.dish,
    address: Faker::Address.full_address,
    description_menu: Faker::Food.description,
    available: true,
    price: rand(500..1500),
    user: users.sample # Assign a random user to each service
  )
end

puts "Service created"

services = Service.all

# Create Bookings
120.times do
  start_date = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  end_date = start_date + rand(1..10).days

  Booking.create!(
    start_date: start_date,
    end_date: end_date,
    confirmed: false,
    user: users.sample, # Assign a random user to each booking
    service: services.sample # Assign a random service to each booking
  )
end

puts "Booking Created"

past_bookings = Booking.where('end_date < ?', Date.today)

# Create Reviews
100.times do
  booking = past_bookings.sample
  Review.create!(
    comment: Faker::Lorem.paragraph,
    rating: rand(0.0..5.0).round(1),
    booking: booking
  )
end

puts "Review created"

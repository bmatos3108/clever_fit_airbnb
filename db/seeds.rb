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

User.create!([
  { email: 'john.doe@example.com', password: 'password1' },
  { email: 'jane.smith@example.com', password: 'password2' },
  { email: 'alice.jones@example.com', password: 'password3' },
  { email: 'bob.brown@example.com', password: 'password4' },
  { email: 'charlie.wilson@example.com', password: 'password5' }
])

puts "Users created"

Service.create!([
  { name: 'London Catering', address: '123 Baker Street, London, UK', description_menu: 'Gourmet meals and snacks', available: true, price: 1000, user: User.all[0] },
  { name: 'Paris Bakery', address: '456 Champs-Élysées, Paris, France', description_menu: 'Freshly baked goods and pastries', available: true, price: 500, user: User.all[1] },
  { name: 'Berlin Bistro', address: '789 Alexanderplatz, Berlin, Germany', description_menu: 'Local German cuisine and beers', available: true, price: 800, user: User.all[2] },
  { name: 'Rome Restaurant', address: '101 Via Veneto, Rome, Italy', description_menu: 'Italian fine dining', available: true, price: 1200, user: User.all[3] },
  { name: 'New York Deli', address: '202 Broadway, New York, USA', description_menu: 'Classic deli sandwiches and soups', available: true, price: 900, user: User.all[4] }
])

puts "Service created"

Booking.create!([
  { start_date: '2024-07-01', end_date: '2024-07-05', confirmed: true, user: User.all[4], service: Service.all[0] },
  { start_date: '2024-07-06', end_date: '2024-07-10', confirmed: true, user: User.all[3], service: Service.all[1] },
  { start_date: '2024-07-11', end_date: '2024-07-15', confirmed: true, user: User.all[2], service: Service.all[2] },
  { start_date: '2024-07-16', end_date: '2024-07-20', confirmed: true, user: User.all[1], service: Service.all[3] },
  { start_date: '2024-07-21', end_date: '2024-07-25', confirmed: true, user: User.all[0], service: Service.all[4] }
])

puts "Booking Created"

Review.create!([
  { comment: 'Amazing service!', rating: 5.0, booking: Booking.all[0] },
  { comment: 'Very good, will use again.', rating: 4.5, booking: Booking.all[1] },
  { comment: 'Food was excellent!', rating: 4.8, booking: Booking.all[2] },
  { comment: 'Great experience overall.', rating: 4.3, booking: Booking.all[3] },
  { comment: 'Highly recommend!', rating: 5.0, booking: Booking.all[4] }
])

puts "Review created"

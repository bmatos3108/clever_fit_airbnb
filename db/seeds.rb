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

# Define image URLs
image_urls = [
  'https://cdn.prod.website-files.com/655f92d91d173d2aa1084856/65649e33431fc94dd613d475_Portraits%20holding%20dish%20-%20BFF%20046.webp',
  'https://img.bestrecipes.com.au/iyddCRce/br/2019/02/1980-crunchy-chicken-twisties-drumsticks-951509-1.jpg',
  'https://media.cnn.com/api/v1/images/stellar/prod/160929101749-essential-spanish-dish-paella-phaidon.jpg?q=w_1900,h_1069,x_0,y_0,c_fill',
  'https://www.eatright.org/-/media/images/eatright-landing-pages/foodgroupslp_804x482.jpg?as=0&w=967&rev=d0d1ce321d944bbe82024fff81c938e7&hash=E6474C8EFC5BE5F0DA9C32D4A797D10D',
  'https://media.istockphoto.com/id/1316145932/photo/table-top-view-of-spicy-food.jpg?b=1&s=612x612&w=0&k=20&c=X6CkFGpSKhNZeiii8Pp2M_YrBdqs7tRaBytkGi48a0U='
]

# Create Services
150.times do
  service = Service.create!(
    name: Faker::Food.dish,
    address: Faker::Address.full_address,
    description_menu: Faker::Food.description,
    available: true,
    price: rand(500..1500),
    user: users.sample  # Assign a random user to each service
  )

  # Attach random images
  rand(3..5).times do
    image_url = image_urls.sample
    begin
      image_io = URI.open(image_url)
      service.images.attach(io: image_io, filename: "#{service.name.parameterize}-image.jpg")
    rescue OpenURI::HTTPError => e
      puts "Error fetching image from #{image_url}: #{e.message}"
    end
  end
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

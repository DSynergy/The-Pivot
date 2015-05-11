class Seed
  def call
    realistic_categories
    realistic_users
    generate_realistic_listings
    generate_realistic_pictures
    generate_categories
    generate_users
    generate_listings
    generate_pictures
    generate_reservations
  end

  def realistic_users
    User.create(username: "Dustin", password: "password", email_address: "travelhome.turing@gmail.com", role:0, avatar: "admin-dash.jpg", credit_card: "4242424242424242", billing_address: "address")
    User.create(username: "Kyra", password: "password", email_address: "travelhome2.turing@gmail.com", role:0, avatar: "admin-dash.jpg", credit_card: "4242424242424242", billing_address: "address")
    User.create(username: "Richard", password: "password", email_address: "richard@example.com", role:0, avatar: "default_image.jpg", credit_card: "4242424242424242", billing_address: "address")
    User.create(username: "Admin", password: "admin", email_address: "admin@example.com", role:0, avatar: "default_image.jpg", credit_card: "4242424242424242", billing_address: "address")
  end

  def realistic_categories
    Category.create(name: "condo")
    Category.create(name: "teepee")
    Category.create(name: "cabin")
    Category.create(name: "mansion")
    Category.create(name: "house")
  end

  def generate_realistic_listings
    user = User.find_by(username: "Dustin")
      listing = user.listings.create!(title: "Denver Condo", description: "My condo is the shit. You should stay here dawg.",
                                      private_bathroom: true, price: 75.00.to_f,
                                      quantity_available: 1, people_per_unit: 2,
                                      start_date: "04/17/2015", end_date: "04/21/2015", status: 0,
                                      street_address: Faker::Address.street_address, city: "Denver",
                                      state: "Colorado", country: "'Merkia",
                                      zipcode: "80206")
      listing.categories << Category.find_by(name: "condo")
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
      listing = user.listings.create!(title: "Leadville Cabin", description: "My cabin sort of sucks, but hey it is cheap. You should stay here I guess.",
                                      private_bathroom: true, price: 15.00.to_f,
                                      quantity_available: 1, people_per_unit: 3,
                                      start_date: "04/17/2015", end_date: "04/21/2015", status: 0,
                                      street_address: Faker::Address.street_address, city: "Leadville",
                                      state: "Colorado", country: "'Merkia",
                                      zipcode: "80000")
      listing.categories << Category.find_by(name: "cabin")
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
      listing = user.listings.create!(title: "La Junta TeePee", description: "I NEED MONEY! PLEASE STAY!",
                                      private_bathroom: true, price: 5.00.to_f,
                                      quantity_available: 1, people_per_unit: 3,
                                      start_date: "04/17/2015", end_date: "12/31/2015", status: 0,
                                      street_address: Faker::Address.street_address, city: "La Junta",
                                      state: "Colorado", country: "'Merkia",
                                      zipcode: "82360")
      listing.categories << Category.find_by(name: "cabin")
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
    user2 = User.find_by(username: "Richard")
      listing = user2.listings.create!(title: "Sweet Highlands House", description: "My highlands home is super sweet. Way better than Denver Condos. You should stay here.",
                                      private_bathroom: true, price: 175.00.to_f,
                                      quantity_available: 2, people_per_unit: 2,
                                      start_date: "04/17/2015", end_date: "04/21/2015", status: 0,
                                      street_address: Faker::Address.street_address, city: "Denver",
                                      state: "Colorado", country: "'Merkia",
                                      zipcode: "80220")
      listing.categories << Category.find_by(name: "house")
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
    user3 = User.find_by(username: "Kyra")
      listing = user3.listings.create!(title: "Boulder Mansion", description: "My Boulder Mansion is the sickest! Way better than the shit you find in Denver. You should stay here!.",
                                      private_bathroom: true, price: 275.00.to_f,
                                      quantity_available: 2, people_per_unit: 2,
                                      start_date: "04/17/2015", end_date: "04/21/2015", status: 0,
                                      street_address: Faker::Address.street_address, city: "Boulder",
                                      state: "Colorado", country: "'Merkia",
                                      zipcode: "80302")
      listing.categories << Category.find_by(name: "mansion")
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
  end

  def generate_realistic_pictures
      Listing.find_by(title: "Denver Condo").pictures << Picture.create(avatar: "denver_condo.jpg")
      Listing.find_by(title: "Leadville Cabin").pictures << Picture.create(avatar: "cabin.jpg")
      Listing.find_by(title: "La Junta TeePee").pictures << Picture.create(avatar: "teepee.jpg")
      Listing.find_by(title: "Sweet Highlands House").pictures << Picture.create(avatar: "highlands_house.jpg")
      Listing.find_by(title: "Boulder Mansion").pictures << Picture.create(avatar: "Boulder_mansion.jpg")
  end

  def generate_users
    500.times do
      user = User.create(username: Faker::Name.first_name, password: "password", email_address: Faker::Internet.email,
                         role: 0, avatar: Faker::Avatar.image, credit_card: Faker::Number.number(16),
                         billing_address: Faker::Lorem.sentence)
      puts "User: #{user.username}"
    end
  end

  def generate_listings
    50.times do
      user = User.order("RANDOM()").limit(1).first
      listing = user.listings.create!(title: Faker::Company.name, description: Faker::Lorem.sentence,
                                      private_bathroom: [true, false].sample, price: Faker::Commerce.price.to_f,
                                      quantity_available: rand(1..4), people_per_unit: rand(1..10),
                                      start_date: generate_start_dates, end_date: generate_end_dates, status: rand(1),
                                      street_address: Faker::Address.street_address, city: Faker::Address.city,
                                      state: Faker::Address.state, country: Faker::Address.country,
                                      zipcode: Faker::Address.zip)
      listing.categories << Category.find(rand(1..25))
      puts "Listing: #{listing.title}, #{listing.categories.first.name}"
    end
  end

  def generate_pictures
    Listing.all.each do |listing|
      listing.pictures << Picture.create(avatar: "default_image.jpg")
      puts "#{listing.pictures.first.avatar}"
    end
  end

  def generate_start_dates
    [
      "08/10/2015", "08/12/2015", "08/13/2015", "08/14/2015", "08/15/2015"
    ].sample
  end

  def generate_end_dates
    [
      "08/20/2015", "08/22/2015", "08/23/2015", "08/24/2015", "08/25/2015"
    ].sample
  end

  def generate_categories
    25.times do
      Category.create(name: Faker::Name.name)
    end
  end

  def generate_reservations
    User.all.each do |user|
      10.times do
        booking = user.bookings.create
        booking.reservations.create(user_id: user.id, status: rand(2), listing_id: rand(1..30), start_date: "08/10/2015", end_date: "08/12/2015" )
      end
    end
  end

  def self.call
    new.call
  end
end

Seed.call

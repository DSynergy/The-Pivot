class Seed
  def call
    generate_categories
    generate_users
    generate_listings
    generate_pictures
    generate_reservations
    realistic_users
    realistic_categories
  end

  def realistic_users
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

  def realistic_listings
  end

  def generate_users
    500.times do
      user = User.create(username: Faker::Name.name, password: "password", email_address: Faker::Internet.email,
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
                           zipcode: Faker::Address.zip) do |listing|
        listing.categories << Category.find(rand(1..25))
        puts "Listing: #{listing.title}, #{listing.categories.first.name}"
      end
    end
  end

  def generate_pictures
    Listing.all.each do |listing|
      listing.pictures << Picture.create(url: "default_image.jpg")
      puts "#{listing.pictures.first.url }"
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

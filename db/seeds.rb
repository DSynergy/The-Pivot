class Seed
  def call
    generate_categories
    generate_users
    generate_listings
    generate_pictures
    generate_bookings
  end

  def generate_users
    50.times do
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
                           available_dates: generate_dates, status: rand(1),
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

  def generate_dates
    [
     {"1" => 1, "1" => 2, "1"=> 3},{ "2" => 2, "2" => 3}, {"3"=>15, "3"=>16}
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
          user.reservations.create(status: rand(2))
        end
      end
  end

  def generate_cart
    [
      {"1" => generate_dates},
      {"1" => generate_dates},
      {"1" => generate_dates}
    ].sample
  end

  def self.call
    new.call
  end
end

Seed.call

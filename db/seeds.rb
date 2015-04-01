class Seed
  def call
    generate_categories
    generate_users
    generate_listings
    generate_bookings
  end

  def generate_users
    10.times do
      user = User.create(username: Faker::Name.name, password: "password", email_address: Faker::Internet.email,
                  role: 0, avatar: Faker::Avatar.image, credit_card: Faker::Number.number(16),
                  billing_address: Faker::Lorem.sentence)
      puts "User: #{user.username}"
    end
  end

  def generate_listings
    50.times do
      user = User.order("RANDOM()").limit(1).first
      listing = user.listings.create(title: Faker::Company.name, description: Faker::Lorem.sentence,
                           private_bathroom: [true, false].sample, price: Faker::Commerce.price, 
                           quantity_available: rand(1..4), people_per_unit: rand(1..10), 
                           available_dates: generate_dates, status: rand(2), 
                           street_address: Faker::Address.street_address, city: Faker::Address.city, 
                           state: Faker::Address.state, country: Faker::Address.country, 
                           zipcode: Faker::Address.zip) do |listing|
        listing.categories.build(id: Category.find(rand(1..@category_count)))
        listing.pictures.build(url: "default_image")
        puts "Listing: #{listing.title}, #{listing.categories.first.name}, #{listing.pictures.first.url}"
      end
    end 
  end

  def generate_dates
    [
     {"Jan3" => 0, "Jan4" => 0, "Jan5" => 0},
     {"Mar11" => 0, "March12" => 0},
     {"July3" => 0, "July4" => 0, "July5" => 0, "July6" => 0}
    ].sample
  end

  def generate_categories
    category_contents = ([{ name: "Apartment"}, { name: "Condo" }, { name: "Cabin"}, { name: "Treehouse"},
                  { name: "Room" }, { name: "Mansion" }])

    @category_count = category_contents.size
    category_contents.each do |content| 
      category = Category.create(content) 
      puts "Category: #{category.name}"
    end
  end

  def generate_bookings
    10.times do
      user = User.order("RANDOM()").limit(1).first
      booking = user.bookings.create(status: rand(2), cart: generate_cart)
      puts "#{booking.cart}"
    end
  end

  def generate_cart
    [
     {"1" => generate_dates},
     {"2" => generate_dates},
     {"3" => generate_dates}
    ].sample
  end

  def self.call
    new.call
  end
end

Seed.call

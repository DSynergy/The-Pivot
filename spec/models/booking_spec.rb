require 'rails_helper'

RSpec.describe Booking, type: :model do

  def create_listing
    Listing.create(title: "Bacon Maple Crunch",
                   description: "see title",
                   price: 8.00,
                   quantity_available: 2,
                   people_per_unit: 2,
                   private_bathroom: true,
                   available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                   user_id: 2,
                   country: 'USA',
                   state: 'Colorado',
                   city: 'Denver',
                   zipcode: '80206',
                   street_address: '1510 Blake St',
                   status: 0)
   Listing.create(title: "My house",
                  description: "see title",
                  price: 8.00,
                  quantity_available: 2,
                  people_per_unit: 2,
                  private_bathroom: true,
                  available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                  user_id: 2,
                  country: 'USA',
                  state: 'Colorado',
                  city: 'Denver',
                  zipcode: '80206',
                  street_address: '1510 Blake St',
                  status: 0)
  Listing.create(title: "Downtown Hipster Condo",
                 description: "see title",
                 price: 8.00,
                 quantity_available: 2,
                 people_per_unit: 2,
                 private_bathroom: true,
                 available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                 user_id: 2,
                 country: 'USA',
                 state: 'Colorado',
                 city: 'Denver',
                 zipcode: '80206',
                 street_address: '1510 Blake St',
                 status: 0)
  end

  def new_cart
    {1 => {"Jan3" => 0, "Jan4" => 0, "Jan5" => 0},
    3 => {"Mar11" => 0, "Mar12" => 0},
    2 => {"July3" => 0, "July4" => 0, "July5" => 0, "July6" => 0}}
  end

  def generate_bookings
    user = create(:user)
    user.bookings.create(status: 0, cart: new_cart)
  end

  it "has a default status of pending" do
    generate_bookings
    expect(Booking.first.status).to eq("pending")
  end

  it "belongs to a user" do
    user = create(:user)
    user.bookings.create(status:0, cart: {"1" => 3} )
    expect(Booking.first.user_id).to eq(user.id)
  end

  it "has a cart" do
    # returns slashes.  Must deal with it soon.
    generate_bookings
    expect(Booking.first.cart["1"]).to eq('{"Jan3"=>0, "Jan4"=>0, "Jan5"=>0}')
  end

  describe "cart" do
    it "can access the days per listing" do
      create_listing
      generate_bookings
      parsed_cart = Booking.first.total_days_per_booking
      expect(parsed_cart).to eq(9)
    end

    it "can access the listings in the cart" do
      create_listing
      generate_bookings
      parsed_cart = Booking.first.listings_per_cart
      expect(parsed_cart).to eq(3)
    end
  end

  describe ".generate_booking" do
    it "creates an booking from the cart" do
      expect(Booking.count).to eq(0)
      user = create(:user)
      user.bookings.create(status: 0, cart: new_cart)

      expect(Booking.count).to eq(1)
      expect(user.bookings.first.cart.size).to eq(3)
    end

  end

  describe ".sort_by_status" do
    it "returns all bookings associated with the passed in status" do
      user = create(:user)
      user.bookings.create(status: 0, cart: new_cart)
      user.bookings.create(status: 0, cart: new_cart)
      user.bookings.create(status: 1, cart: new_cart)

      expect(Booking.sort_by_status('0').count).to eq(2)
      expect(Booking.sort_by_status('1').count).to eq(1)
    end
  end



end

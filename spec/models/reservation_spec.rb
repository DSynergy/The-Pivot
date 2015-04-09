require 'rails_helper'

RSpec.describe Reservation, type: :model do

  let!(:listing) {Listing.create(title: "Bacon Maple Crunch",
                               description: "see title",
                               price: 8.00,
                               quantity_available: 2,
                               people_per_unit: 2,
                               private_bathroom: true,
                               available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                               user_id: 1,
                               country: 'USA',
                               state: 'Colorado',
                               city: 'Denver',
                               zipcode: '80206',
                               street_address: '1510 Blake St',
                               status: 0)}

  let!(:user) {User.create(username: "Sally",
                          email_address: "sadsal@example.com",
                          password: "password",
                          role: 0,
                          credit_card: '1234-5678-9012-3456',
                          billing_address: 'blahblahblah',
                          display_name: 'SuperStarSally123')}

  let!(:booking) {user.bookings.create(trip_name: "My summer getaway")}


  let!(:reservation) {user.reservations.create(listing_id: 2,
                                         booking_id: 1,
                                         status: 0,
                                         start_date: '05/01/2015',
                                         end_date: '05/05/2015')}

  it "belongs to booking" do
    expect(booking.reservations.first.id).to eq(1)
  end

  it "belongs to a listing" do
    expect(reservation.listing.title).to eq("Bacon Maple Crunch")
  end

  it "belongs to a user" do
    expect(user.reservations.first.id).to eq(3)
  end

  it "its original status is pending" do
    expect(reservation.status).to eq("pending")
  end

end

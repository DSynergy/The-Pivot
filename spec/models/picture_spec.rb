
require 'rails_helper'

RSpec.describe Picture, type: :model do

  it "has a listing associated with it" do

    listing = Listing.create( title: "Bacon Maple Crunch",
                             description: "see title",
                             price: 8.00,
                             quantity_available: 2,
                             people_per_unit: 2,
                             private_bathroom: true,
                             start_date: "08/12/2015",
                             end_date: "08/14/2015",
                             user_id: 2,
                             country: 'USA',
                             state: 'Colorado',
                             city: 'Denver',
                             zipcode: '80206',
                             street_address: '1510 Blake St',
                             status: 0)

    listing.pictures.create(avatar: "avatar")
    expect(listing.pictures.count).to eq(1)
  end
end


require 'rails_helper'

RSpec.describe Picture, type: :model do
  it "has a url" do
    picture = Picture.new(url: "url")
    expect(picture.url).to eq("url")
  end

  it "has a listing associated with it" do

    listing = Listing.create( title: "Bacon Maple Crunch",
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

    listing.pictures.create(url: "url")
    expect(listing.pictures.count).to eq(1)
  end
end

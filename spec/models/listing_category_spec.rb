require 'rails_helper'

RSpec.describe ListingCategory do
  it "has an listing associated with a category" do
    listing = create(:listing, available_dates: {"Jan1"=>0, "Jan2"=>0})
    category = create(:category)
    category_2 = create(:category, name: "Early Brunch")
    listing_category = create(:listing_category, listing_id: listing.id, category_id: category.id)
    listing.categories << category_2

    expect(listing.categories.first).to eq(category)
    expect(listing.categories.last).to eq(category_2)
  end

  it "can add listings to a category" do
    category = create(:category)
    listing_1 = create(:listing, title: "Dry Bread", available_dates: '{"Jan1"=>0, "Jan2"=>0}')
    listing_2 = create(:listing, title: "Wet Bread", available_dates: '{"Jan1"=>0, "Jan2"=>0}')
    category.listings.push(listing_1).push(listing_2)

    expect(category.listings.count).to eq(2)
    expect(category.listings.first).to eq(listing_1)
  end

  it "can have an listing removed from a category" do
    category = create(:category)
    listing_1 = create(:listing, title: "Dry Bread", available_dates: '{"Jan1"=>0, "Jan2"=>0}')
    category.listings.push(listing_1)

    expect(category.listings.count).to eq(1)

    listing_1.categories.delete(category)

    expect(category.listings.count).to eq(0)
  end

  it "does not allow for a duplicate entry" do
    ListingCategory.create(category_id: 1, listing_id: 1)
    duplicate = ListingCategory.new(category_id: 1, listing_id: 1)

    expect(duplicate).not_to be_valid
  end

  #change to listing

end

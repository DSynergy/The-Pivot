require 'rails_helper'

RSpec.describe Cart do
  let!(:listing_1) { create(:listing, id: 1, start_date: "08/12/2015", end_date: "08/13/2015" )}
  let(:listing_2) { create(:listing, id: 2, title: "Strawberry Toast", start_date: "08/12/2015", end_date: "08/13/2015" )}
  let(:cart) { Cart.new(nil) }

  it "has a hash of content by default" do
    expect(cart.content.class).to eq(Hash)
  end

  describe "#add_listing" do

    it "can have a listings added" do
      cart.add_listing(listing_1.id, [listing_1.start_date, listing_1.end_date])
      expect(cart.content).to eq({ 1 => [["08/12/2015", "08/13/2015"]] })
    end

  end

  describe "#remove_listing" do

    it "can have listings removed" do
      cart.add_listing(listing_1.id, [listing_1.start_date, listing_1.end_date])
      cart.add_listing(listing_2.id, [listing_1.start_date, listing_1.end_date])

      expect(cart.listings_per_cart).to eq(2)
      cart.remove_listing(listing_1.id)
      expect(cart.listings_per_cart).to eq(1)
    end

    it "deletes listing pair from cart if the last one is removed" do
      cart = Cart.new({1 => 1})

      cart.remove_listing(listing_1.id)

      expect(cart.content).to be_empty
    end

  end

  describe "#listings_with_dates" do

    it "returns date range that listing is requested for" do
      cart = Cart.new({1=>{1 => 1, 1 => 3}})
      expect(cart.listings_with_dates.keys.first.title).to eq("Bacon Maple Crunch")
    end

  end
end

require 'rails_helper'

RSpec.describe Cart do
  let!(:listing_1) { create(:listing, id: 1, available_dates: '{4 => {1=>1}, 1=>2}}') }
  let(:listing_2) { create(:listing, id: 2, title: "Strawberry Toast", available_dates: '{4 => {1=>1}, 1=>2}}' ) }
  let(:cart) { Cart.new(nil) }
  let(:total_quantity) { cart.content.values.reduce(:+) }

 it "has a hash of content by default" do
    expect(cart.content.class).to eq(Hash)
  end

  describe "#add_listing" do

    it "can have a listings added" do
      cart.add_listing(listing_1.id, listing_1.available_dates)
      expect(cart.content).to eq(1 => {"{4"=>"{1", "1"=>"2}}"})
    end

  end

  describe "#remove_listing" do

    xit "can have listings removed" do
      5.times { cart.add_listing(listing_1.id) }

      expect(total_quantity).to eq(5)
      expect(cart.remove_listing(listing_1.id)).to eq(4)
    end

    xit "deletes listing pair from cart if the last one is removed" do
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

  describe "#empty cart" do

    xit "cannot be empty" do
    end
  end
end

require 'rails_helper'

RSpec.describe Cart do
  let(:listing_1) { create(:listing, id: 1, available_dates: '{4 => {"Jan1"=>0, "Jan2"=>0}}') }
  let(:listing_2) { create(:listing, id: 2, title: "Strawberry Toast", available_dates: '{4 => {"Jan1"=>0, "Jan2"=>0}}') }
  let(:cart) { Cart.new(nil) }
  let(:total_quantity) { cart.content.values.reduce(:+) }

 xit "has a hash of content by default" do
    expect(cart.content.class).to eq(Hash)
  end

  describe "#add_listing" do

    xit "can have listings added" do
      3.times { cart.add_listing(listing_1.id) }
      2.times { cart.add_listing(listing_2.id) }
      expect(cart.content).to eq('{4 => {"Jan1"=>0, "Jan2"=>0}}')
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

  describe "#total_quantity" do

    xit "returns total number of listings in cart" do
      5.times { cart.add_listing(listing_1.id) }

      expect(total_quantity).to eq(5)
    end

  end


end

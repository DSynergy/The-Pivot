require 'rails_helper'

RSpec.describe Cart do
  let(:item_1) { create(:item, id: 1) }
  let(:item_2) { create(:item, id: 2, name: "Strawberry Toast") }
  let(:cart) { Cart.new(nil) }
  let(:total_quantity) { cart.content.values.reduce(:+) }

  it "has a hash of content by default" do
    expect(cart.content.class).to eq(Hash)
  end

  describe "#add_item" do

    it "can have items added" do
      3.times { cart.add_item(item_1.id) }
      2.times { cart.add_item(item_2.id) }

      expect(cart.content).to eq({1 => 3, 2 => 2})
    end

  end

  describe "#remove_item" do

    it "can have items removed" do
      5.times { cart.add_item(item_1.id) }

      expect(total_quantity).to eq(5)
      expect(cart.remove_item(item_1.id)).to eq(4)
    end

    it "deletes item pair from cart if the last one is removed" do
      cart = Cart.new({1 => 1})

      cart.remove_item(item_1.id)

      expect(cart.content).to be_empty
    end

  end

  describe "#total_quantity" do

    it "returns total number of items in cart" do
      5.times { cart.add_item(item_1.id) }

      expect(total_quantity).to eq(5)
    end

  end

end

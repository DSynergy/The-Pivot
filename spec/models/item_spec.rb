require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { create(:item, name: "Bacon Maple Crunch",
                             description: "see name",
                             price: 8.00) }

  it "is valid" do
    expect(item).to be_valid
  end

  it "is invalid without a name" do
    item.name = nil
    expect(item).not_to be_valid
  end

  it "is invalid without a description" do
    item.description = nil
    expect(item).not_to be_valid
  end

  it "must have unique name" do
    item
    expect { create(:item, name: "Bacon Maple Crunch") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "not retired by default" do
    expect(item.retired?).to be false
  end

  it "has a decimal price, greater than zero" do
    expect { create(:item, price: 0) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "is invalid with a description over 300 characters" do
    expect { create(:item, description: "jssssssssssssssssssssssssssssssssss
      sssssssssssssssssssssssss
      okmksmoksmokmsokms
      okmssmoksmksmoksmomfresokmroeksmokrmeoksmok
      rmeoskmrokemsokmroskmikrm
      soikmroksmokrmoeskmroekmsokrmeoskmroekmsok
      rmeoskmrokmesokmroskmorkmesokmroeksmokmroeskmorkmesokrmeoskmro
      eksmorkemsokrmeoskmreosresreso
      kmkmimkormoskmokrmsokmomkokj")}.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe ".active_items" do
    it "returns all active items" do
      item
      create(:item, name: "Test Toast")
      create(:item, name: "Lazy Toast", retired: true)

      expect(Item.count).to eq(3)
      expect(Item.active_items.count).to eq(2)
    end
  end

end

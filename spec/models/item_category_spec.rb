require 'rails_helper'

RSpec.describe ItemCategory do
  it "has an item associated with a category" do
    item = create(:item)
    category = create(:category)
    category_2 = create(:category, name: "Early Brunch")
    item_category = create(:item_category, item_id: item.id, category_id: category.id)
    item.categories << category_2

    expect(item.categories.first).to eq(category)
    expect(item.categories.last).to eq(category_2)
  end

  it "can add items to a category" do
    category = create(:category)
    item_1 = create(:item, name: "Dry Bread")
    item_2 = create(:item, name: "Wet Bread")
    category.items.push(item_1).push(item_2)

    expect(category.items.count).to eq(2)
    expect(category.items.first).to eq(item_1)
  end

  it "can have an item removed from a category" do
    category = create(:category)
    item_1 = create(:item, name: "Dry Bread")
    category.items.push(item_1)

    expect(category.items.count).to eq(1)

    item_1.categories.delete(category)

    expect(category.items.count).to eq(0)
  end

  it "does not allow for a duplicate entry" do
    ItemCategory.create(category_id: 1, item_id: 1)
    duplicate = ItemCategory.new(category_id: 1, item_id: 1)

    expect(duplicate).not_to be_valid
  end

end

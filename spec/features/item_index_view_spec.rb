require 'rails_helper'

RSpec.describe "Item index" do
  let!(:item) { create(:item, id: 1, name: "Avocado Toast") }
  let!(:retired_item) { create(:item, retired: true) }
  before(:each) { visit items_path }

  it "has a link to add item to cart" do
    expect(page).to have_button("Add to Cart")
  end

  it "can click a link to add item to cart" do
    first(:button, "Add to Cart").click

    within("#flash_notice") do
      expect(page).to have_content("Avocado Toast")
    end
  end

  it "does not show retired items" do
    expect(page).not_to have_content("Cheese Toast")
  end
end

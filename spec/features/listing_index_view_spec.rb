require 'rails_helper'

RSpec.describe "listing index" do
  let!(:listing) { create(:listing, id: 1, name: "Avocado Toast") }
  let!(:retired_listing) { create(:listing, retired: true) }
  before(:each) { visit listings_path }

  it "has a link to add listing to cart" do
    expect(page).to have_button("Add to Cart")
  end

  it "can click a link to add listing to cart" do
    first(:button, "Add to Cart").click

    within("#flash_notice") do
      expect(page).to have_content("Avocado Toast")
    end
  end

  it "does not show retired listings" do
    expect(page).not_to have_content("Cheese Toast")
  end
end

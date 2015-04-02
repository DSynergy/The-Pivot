require 'rails_helper'

RSpec.describe "Listing show" do
  let(:listing) { create(:listing) }

  it "displays listing title" do
    visit listing_path(listing)
    within('#listing-title') do
      expect(page).to have_content("Cheese Toast")
    end
  end

  it "displays listing description" do
    visit listing_path(listing)
    within("#listing-description") do
      expect(page).to have_content("Super cheesy bread food")
    end
  end

  it "display listings price" do
    visit listing_path(listing)
    within("#listing-price") do
      expect(page).to have_content("3.00")
    end
  end

  it "displays a custom picture" do
    visit listing_path(listing)
    within(".default-pic") do
      expect(page).to have_css("img")
    end
  end

  it "has a link to add listing to cart" do
    visit listing_path(listing)

    expect(page).to have_button("Add to Cart")

    click_link_or_button("Add to Cart")

    expect(current_path).to eq(listing_path(listing))
    expect(page).to have_selector("#flash_notice")
  end

  context "when a user clicks an listing from a previous order thats been retired" do
    it "notes if listing is retired" do
      user = create(:user)
      listing = Listing.create(name: "apple toast", description: "blah", price: 2.00, retired: true)
      user.orders.create(status: 0, cart: { listing.id => 1 })

      login_as(user)
      visit orders_path
      click_link_or_button("apple toast")
      within("#retired-listing") do
        expect(page).to have_content("#{listing.name} has been retired from the menu")
      end
      expect(page).not_to have_content("Add to Cart")
    end
  end

end

require 'rails_helper'

RSpec.describe "Listing show" do

  let!(:listing) { Listing.create({title: "Bacon Maple Crunch",
                                   description: "see title",
                                   price: 8.00,
                                   quantity_available: 2,
                                   people_per_unit: 2,
                                   private_bathroom: true,
                                   available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                                   user_id: 2,
                                   country: 'USA',
                                   state: 'Colorado',
                                   city: 'Denver',
                                   zipcode: '80206',
                                   street_address: '1510 Blake St',
                                   status: 0})}


  it "displays listing title" do
    visit root_path
    click_on("Browse All Listings")
    expect(current_path).to eq(listings_path)
    click_on("Bacon Maple Crunch")
    expect(current_path).to eq(listing_path(listing))
    within('#listing-title') do
      expect(page).to have_content("Bacon Maple Crunch")
    end
  end

 it "displays listing description" do
    visit listing_path(listing)
    within("#listing-description") do
      expect(page).to have_content("see title")
    end
  end

 it "display listings price" do
    visit listing_path(listing)
    within("#listing-price") do
      expect(page).to have_content("8.00")
    end
  end

 it "displays a custom picture" do
    visit listing_path(listing)
      expect(page).to have_css("img")
  end

  it "has a link to add listing to cart" do
    visit listing_path(listing)

    expect(page).to have_button("Add to Cart")

    click_link_or_button("Add to Cart")

    expect(current_path).to eq(listing_path(listing))
    expect(page).to have_selector("#flash_notice")
  end

  context "when a user clicks an listing from a previous order thats been retired" do
    xit "notes if listing is retired" do
      user = create(:user)
      user.bookings.create(status: 0, cart: { listing.id => {"Jan1"=>0, "Jan2"=>0 }})

      login_as(user)
      visit user_bookings_path(slug: user.username)
      click_link_or_button("#{listing.id}")
      within("#retired-listing") do
        expect(page).to have_content("#{listing.title} has been retired from the menu")
      end
      expect(page).not_to have_content("Add to Cart")
    end
  end

end

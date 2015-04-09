require 'rails_helper'

RSpec.describe "Booking" do
  before(:each)  do
    user = create(:user)
    set_current_user(user)
    listing1 = create(:listing, available_dates: { 1=> {1=>4, 1=>7}})
    listing1.pictures.create(url: "default-image")
    visit listing_path(listing1)
    fill_in("listing[start_date]", with: "05/01/2015")
    fill_in("listing[end_date]", with: "05/02/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path
    click_link_or_button("Book Itinerary")
    visit orders_path
  end

  it "shows status of order in user's order history" do
    expect(page).to have_content("Status: ordered")
  end

  it "shows a readable updated at date for order" do
    expect(page).to have_content("ago")
    expect(page).to have_content("Updated:")
  end

  it "shows line-item totals for each item" do
    expect(page).to have_content("$3.00")
  end

  it "shows a total for the entire order" do
    expect(page).to have_content("$6.00")
  end

end

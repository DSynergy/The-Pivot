require 'rails_helper'

RSpec.describe "Authenticated User profile" do
  let!(:user) { create(:user) }
  before(:each) { set_current_user(user) }

  it "submits an order when cart is checked out", js: true do
    listing1 = create(:listing, available_dates: {1 => { 1=>4, 1=>5 }})
    listing1.pictures.create(url: "default_image.jpg")
    visit listing_path(listing1)
    fill_in("listing[start_date]", with: "11/01/2015")
    fill_in("listing[end_date]", with: "11/07/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path
    expect(page).to have_content("Bacon Maple Crunch")
    click_link_or_button("Book Itinerary")
    a = page.driver.browser.switch_to.alert
    a.accept
    visit traveler_path(user.id)

    expect(page).to have_content("Cheese Toast")
  end

  xit "can click Order History link to be taken to Order History page" do
    visit root_path
    click_link_or_button("Traveler Page")

    expect(current_path).to eq(travelers_path(user.id))
    expect(page).to have_content("#{user.display_name ? user.display_name : user.username}'s Orders")
  end

  it "sees Order History" do
    user.bookings.create(cart: {1 => { 1=>4, 1=>5 }})

    visit user_bookings_path(user.username)

    expect(page).to have_content("Cheese Toast")
  end
end

require 'rails_helper'

RSpec.describe "Authenticated User profile" do
  let!(:user) { create(:user) }
  before(:each) { set_current_user(user) }

  it "submits an order when cart is checked out", js: true do
    listing1 = create(:listing, start_date: "09/10/2015", end_date: "09/11/2015")
    listing1.pictures.create(avatar: "default_image.jpg")
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

    expect(page).to have_content("#{listing1.title}")
  end

end

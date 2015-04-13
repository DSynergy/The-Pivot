require 'rails_helper'

RSpec.describe "Cart" do
  before(:each) do
    listing =  create(:listing, start_date: "08/12/2015", end_date: "08/13/2015")
    listing.categories.create(name: "home")
    listing.pictures.create(avatar: "default_image.jpg")
    visit listing_path(listing)
  end

  it "shows a list of cart listings", js: true do
    fill_in('listing[start_date]', with: "05/10/2015")
    fill_in('listing[end_date]', with: "05/13/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")
  end

 it "can remove a listing from the cart", js: true do
    fill_in('listing[start_date]', with: "05/10/2015")
    fill_in('listing[end_date]', with: "05/13/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path
    click_link_or_button("remove listing")

    within("#flash_notice") do
      expect(page).to have_content("Bacon Maple Crunch removed from cart")
    end
  end

  it "persists from logged out state to logged in state", js:true do
    fill_in('listing[start_date]', with: "05/10/2015")
    fill_in('listing[end_date]', with: "05/13/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")

    user = create(:user)
    click_link_or_button("Log In")
    fill_in("session[email_address]", with: "#{user.email_address}")
    fill_in("session[password]", with: "#{user.password}" )
    click_link_or_button("Submit")
    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")

    click_link_or_button("Book Itinerary")
    a = page.driver.browser.switch_to.alert
    a.accept

    expect(page).to have_content("Your itinerary has been successfully booked")
  end

end

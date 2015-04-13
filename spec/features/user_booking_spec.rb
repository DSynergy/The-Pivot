require 'rails_helper'

RSpec.describe 'User confirm booking spec' do

  def user_login
    create(:user)
    visit root_path
    click_link_or_button("Log In")
    fill_in("session[email_address]", with: "sadsal@example.com")
    fill_in("session[password]", with: "password")
    first(:css, "#small_submit_button").click
  end

  let!(:listing) { Listing.create({title: "Bacon Maple Crunch",
                                   description: "see title",
                                   price: 8.00,
                                   quantity_available: 2,
                                   people_per_unit: 2,
                                   private_bathroom: true,
                                   user_id: 2,
                                   start_date: "08/10/2015",
                                   end_date: "08/14/2015",
                                   country: 'USA',
                                   state: 'Colorado',
                                   city: 'Denver',
                                   zipcode: '80206',
                                   street_address: '1510 Blake St',
                                   status: 0})}

  let!(:listing2) { Listing.create({title: "Bacon",
                                    description: "see title",
                                    price: 10.00,
                                    quantity_available: 2,
                                    people_per_unit: 2,
                                    private_bathroom: true,
                                    start_date: "08/10/2015",
                                    end_date: "08/14/2015",
                                    user_id: 2,
                                    country: 'USA',
                                    state: 'Colorado',
                                    city: 'Denver',
                                    zipcode: '80206',
                                    street_address: '1510 Blake St',
                                    status: 0})}
  def add_a_booking
    visit listing_path(listing)
    fill_in("listing[start_date]", with: "07/01/2015")
    fill_in("listing[end_date]", with: "07/02/2015")
    click_link_or_button("Add to Itinerary")
  end

  def checkout
    find("#shopping_cart").click
    expect(current_path).to eq(cart_path)
    click_link_or_button("Book Itinerary")
    a = page.driver.browser.switch_to.alert
    a.accept
  end

  context "when not logged in" do

    xit "can pick available dates for reservation and add to cart", js: true do
      listing = create(:listing, title: "house", start_date: "08/12/2015", end_date: "08/15/2015")
      listing.categories.create(name: "house")
      listing.pictures.create(avatar: "default_image.jpg")
      visit listing_path(listing)

      fill_in("listing[start_date]", with: "07/01/2015")
      fill_in("listing[end_date]", with: "07/03/2015")

      click_on("Add to Itinerary")

      expect(page).to have_content("Jul 01 2015: Wednesday - Jul 03 2015: Friday")
    end

    xit "cannot checkout cart", js: true, :driver => :selenium_firefox do
      listing.pictures.create(avatar: "default_image.jpg")
      create(:user, email_address: "ex@ex.com")
      add_a_booking
      find("#shopping_cart").click
      expect(current_path).to eq(cart_path)
      click_link_or_button("Sign in to book itinerary")

      user_login
      within("#flash_notice") do
        expect(page).to have_content("Successfully logged in as SuperStarSally123")
      end
      expect(current_path).to eq(cart_path)
    end

  end

  context "when logged in" do

    xit "can checkout cart", js:true, :driver => :selenium_firefox do
      listing.pictures.create(avatar: "default_image.jpg")
      add_a_booking
      user = create(:user)
      visit root_path
      click_link_or_button("Log In")
      fill_in("session[email_address]", with: "sadsal@example.com")
      fill_in("session[password]", with: "password")
      first(:css, "#small_submit_button").click

      checkout
      within("#flash_notice") do
        expect(page).to have_content("Your itinerary has been successfully booked. Happy travels!")
      end
      expect(current_path).to eq(traveler_path(user))
    end

  end

  context "when viewing profile page after submitting a booking" do

    before(:each) do
      user_login
    end

    xit "shows status of reservation in traverler's booking history", js:true, :driver => :selenium_firefox do

      listing.pictures.create(avatar: "default_image.jpg")
      listing2.pictures.create(avatar: "default_image.jpg")
      visit listing_path(listing)
      fill_in("listing[start_date]", with: "09/01/2015")
      fill_in("listing[end_date]", with: "09/02/2015")
      click_link_or_button("Add to Itinerary")
      checkout
      expect(page).to have_content("status: pending")
    end

    it "shows totals for each reservation", js:true, :driver => :selenium_firefox do
      listing.pictures.create(avatar: "default_image.jpg")
      listing2.pictures.create(avatar: "default_image.jpg")

      visit listing_path(listing)
      fill_in("listing[start_date]", with: "09/01/2015")
      fill_in("listing[end_date]", with: "09/02/2015")
      click_link_or_button("Add to Itinerary")

      visit listing_path(listing2)
      fill_in("listing[start_date]", with: "09/01/2015")
      fill_in("listing[end_date]", with: "09/02/2015")
      click_link_or_button("Add to Itinerary")

      checkout
      expect(page).to have_content('start date: 09/01/2015')
      expect(page).to have_content("$8.00")
      expect(page).to have_content("$10.00")
    end

    xit "shows a total for the entire booking", js:true, :driver => :selenium_firefox do
      listing.pictures.create(avatar: "default_image.jpg")
      listing2.pictures.create(avatar: "default_image.jpg")

      visit listing_path(listing)
      fill_in("listing[start_date]", with: "09/01/2015")
      fill_in("listing[end_date]", with: "09/02/2015")
      click_link_or_button("Add to Itinerary")

      visit listing_path(listing2)
      fill_in("listing[start_date]", with: "09/01/2015")
      fill_in("listing[end_date]", with: "09/02/2015")
      click_link_or_button("Add to Itinerary")

      checkout
      expect(page).to have_content("$18.00")
    end

  end

end

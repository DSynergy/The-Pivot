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
                                   available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                                   user_id: 2,
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
                                available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 1, 'Sep27' => 0, 'Sep28' => 0, 'Sep29' => 1},
                                user_id: 2,
                                country: 'USA',
                                state: 'Colorado',
                                city: 'Denver',
                                zipcode: '80206',
                                street_address: '1510 Blake St',
                                status: 0})}
  def add_a_booking
    visit listing_path(listing)
    fill_in("listing[start_date]", with: "01/01/2015")
    fill_in("listing[end_date]", with: "01/02/2015")
    click_link_or_button("Add to Itinerary")
    expect(current_path).to eq(listing_path(listing))
<<<<<<< HEAD
    expect(page).to have_content("added to itinerary: Jan 01 2015: Thursday - Jan 01 2015: Thursday")
=======
    expect(page).to have_content("added to itinerary: Jan 01 2015: Thursday - Jan 02 2015")
>>>>>>> feec2ffe58b707a7f9db493929d56b5b06ec7150
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
      listing = create(:listing, title: "house", available_dates: '{1=>1, 1=>2, 1=>3}')
      listing.categories.create(name: "house")
      listing.pictures.create(url: "default_image.jpg")
      visit listing_path(listing)

      fill_in("listing[start_date]", with: "01/01/2015")
      fill_in("listing[end_date]", with: "01/03/2015")

      click_on("Add to Itinerary")

      expect(page).to have_content("added to itinerary: Jan 01 2015: Thursday - Jan 03 2015: Saturday")
    end

    xit "cannot checkout cart", js: true, :driver => :selenium_firefox do
      listing.pictures.create(url: "default_image.jpg")
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
      listing.pictures.create(url: "default_image.jpg")
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

  #should work
  # context "when viewing profile page after submitting a booking" do
  #
  #   before(:each) do
  #     user_login
  #     add_a_booking
  #     checkout
  #   end
  #
  #   it "shows status of reservation in traverler's booking history", js:true, :driver => :selenium_firefox do
  #     listing.pictures.create(url: "default_image.jpg")
  #     listing2.pictures.create(url: "default_image.jpg")
  #     expect(page).to have_content("Status: pending")
  #   end
  #
  #   it "shows totals for each reservation", js:true, :driver => :selenium_firefox do
  #     listing.pictures.create(url: "default_image.jpg")
  #     listing2.pictures.create(url: "default_image.jpg")
  #     expect(page).to have_content("$8.00")
  #     expect(page).to have_content("$10.00")
  #   end
  #
  #   it "shows a total for the entire booking", js:true, :driver => :selenium_firefox do
  #     listing.pictures.create(url: "default_image.jpg")
  #     listing2.pictures.create(url: "default_image.jpg")
  #     expect(page).to have_content("$18.00")
  #   end
  #
  # end

end

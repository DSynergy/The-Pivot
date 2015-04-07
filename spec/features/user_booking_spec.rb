require 'rails_helper'

RSpec.describe 'User confirm booking spec' do
  let!(:user) { create(:user) }
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
   def add_a_booking
     visit listing_path(listing)
     save_and_open_page
     fill_in("listing[start_date]", with: "01/01/2015")
     fill_in("listing[end_date]", with: "01/02/2015")
     click_link_or_button("Add to Itinerary")
     expect(current_path).to eq(listing_path(listing))
     expect(page).to have_content("added to itinerary, 01/01/2015-01/02/2015")
   end

   def checkout
     click_link_or_button("Cart")
     expert(current_path).to eq(cart_path)
     click_link_or_button("Book Itinerary")
   end

  context "when not logged in" do

    it "can pick available dates for reservation and add to cart" do
      listing = create(:listing, available_dates: '{{1=>1, 1=>2, 1=>3}}')
      listing.categories.create(name: "house")
      listing.pictures.create(url: "default_image.jpg")
      visit listing_path(listing)

      fill_in("listing[start_date]", with: "01/01/2015")
      fill_in("listing[end_date]", with: "01/03/2015")
      click_on("Add to Itinerary")

      expect(page).to have_content("Successfully added to Itinerary: January 21-23")
    end

    it "cannot checkout cart" do
      add_a_booking
      checkout
        within("#flash_notice") do
          expect(page).to have_content("You must logged in to book your itinerary")
        end
      click_link_or_button("OK")
      expert(current_path).to eq(login_path)
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      click_link_or_button("Submit")
        within("#flash_notice") do
          expect(page).to have_content("Successfully logged in as #{user.username}")
        end
      expert(current_path).to eq(cart_path)
    end

  end

    context "when logged in" do

      it "can checkout cart" do
        login_as(user)
        add_a_booking
        checkout
          within("#flash_notice") do
            expect(page).to have_content("Your itinerary has been successfully booked. Happy travels!")
          end
        expert(current_path).to eq(home_page_path)
      end

    end

end

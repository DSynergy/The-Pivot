require 'rails_helper'

RSpec.describe "User Authorization" do
  let(:user_1) { create(:user, username: "Sally") }
  let(:user_2) { create(:user, username: "Billy", email_address: "billbob@example.com") }
  let!(:listing_1) { create(:listing, id: 1, start_date: "08/13/2015", end_date: "08/15/2015") }
  let!(:listing_2) { create(:listing, id: 2, title: "Beer Toast", start_date: "08/13/2015", end_date: "08/15/2015") }

  before(:each) do
    listing_1.pictures.create(avatar: "default_image.jpg")
    listing_2.pictures.create(avatar: "default_image.jpg")
  end

  context "when logged in as a Default User" do

    it "sees personal booking history", js:true do
      visit root_path
      click_link_or_button("Log In")
      fill_in("session[email_address]", with: user_1.email_address)
      fill_in("session[password]", with: user_1.password)
      first(:css, "#small_submit_button").click

      visit traveler_path(user_1)

      expect(page).to have_content("Welcome SuperStarSally123")
    end

    it "does not see another user's order history", js:true do
      visit root_path
      click_link_or_button("Log In")
      fill_in("session[email_address]", with: user_1.email_address)
      fill_in("session[password]", with: user_1.password)
      first(:css, "#small_submit_button").click

      visit traveler_path(user_2)

      expect(page).to_not have_content("Billy")
      expect(page).to have_content("not authorized")
    end

  end

  context "when not logged in" do

    it "the user is prompted to log in if they visit the bookings path" do
      visit traveler_path(user_1.id)

      expect(page).to have_content("You are not authorized to view that page")
      expect(current_path).to eq(login_path)
    end

  end

end

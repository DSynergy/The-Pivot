require 'rails_helper'

RSpec.describe "Home page" do
  context "as an unauthenticated user" do
    let!(:category_1) { create(:category) }
    let!(:category_2) { create(:category, name: "side listing") }
    let!(:listing) { create(:listing, title: "Avocado Toast", start_date: "08/12/2015", end_date: "08/13/2015") }

    before(:each) do
      visit root_path
      listing.pictures.create(avatar: "default_image.jpg")
    end

    it "shows a link to browse all listings" do
      expect(page).to have_link("Browse All Listings")
    end

    it "shows a link to browse by category" do
      expect(page).to have_link("#{category_1.name}", href: category_path(category_1))
      expect(page).to have_link("#{category_2.name}", href: category_path(category_2))
    end

    it "shows a list of all listings once Browse All Items link is clicked" do
      find_link("Browse All Listings").click

      expect(current_path).to eq(listings_path)

      expect(page).to have_content("Avocado Toast")
    end

    it "can view the cart page by clicking cart link" do
      visit cart_path

      expect(current_path).to eq(cart_path)

      expect(page).to have_content("There are no listings in your cart")
    end

  end
end

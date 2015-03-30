require 'rails_helper'

RSpec.describe "Home page" do
  context "as an unauthenticated user" do
    let!(:category_1) { create(:category) }
    let!(:category_2) { create(:category, name: "side item") }
    let!(:item) { create(:item, name: "Avocado Toast") }

    before(:each) { visit root_path }

    it "shows a link to browse all items" do
      expect(page).to have_link("Browse All Items", href: items_path)
    end

    it "shows a link to browse by category" do
      expect(page).to have_link("#{category_1.name}", href: category_path(category_1))
      expect(page).to have_link("#{category_2.name}", href: category_path(category_2))
    end

    it "shows a list of all items once Browse All Items link is clicked" do
      find_link("Browse All Items", href: items_path).click

      expect(current_path).to eq(items_path)

      expect(page).to have_link("Avocado Toast")
    end

    it "can view the cart page by clicking cart link" do
      expect(page).to have_link("Cart", href: cart_path)

      find_link("Cart", href: cart_path).click

      expect(current_path).to eq(cart_path)

      expect(page).to have_content("There are no items in your cart")
    end

  end
end

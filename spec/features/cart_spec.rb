require 'rails_helper'

RSpec.describe "Cart" do
  before(:each) do
    listing =  create(:listing, start_date: "{2=>3}", end_date: "{2=>4}")
    listing.categories.create(name: "home")
    listing.pictures.create(url: "default_image.jpg")
    visit listing_path(listing)
    fill_in('listing[start_date]', with: "05/10/2015")
    fill_in('listing[end_date]', with: "05/13/2015")
    click_link_or_button("Add to Itinerary")
    save_and_open_page
    visit cart_path
  end

  it "shows a list of cart listings" do
    expect(page).to have_content("Bacon Maple Crunch")
  end

 xit "can remove a listing from the cart" do
    click_link_or_button("Remove Listing")

    within("#flash_notice") do
      expect(page).to have_content("Bacon Maple Crunch removed from cart")
    end
  end

  it "persists from logged out state to logged in state" do
  end

  xit "can increase an item's quantity in the cart" do
    click_link_or_button("Add Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast added to cart")
    end
  end

  xit "persists from logged out state to logged in state" do
    click_link_or_button("Add Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast added to cart")
    end

    user = create(:user)
    login_as(user)
    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")

    click_link_or_button("Checkout")

    expect(page).to have_content("Order successfully submitted")
  end

end

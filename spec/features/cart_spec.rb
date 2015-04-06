require 'rails_helper'

RSpec.describe "Cart" do

  before(:each) do
   @listing = Listing.create(
      title: "Bacon Maple Crunch",
      description: "see title",
      price: 8.00,
      quantity_available: 2,
      people_per_unit: 2,
      private_bathroom: true,
      user_id: 2,
      country: 'USA',
      state: 'Colorado',
      city: 'Denver',
      zipcode: '80206',
      street_address: '1510 Blake St',
      status: 0,
      available_dates: {'Jan1' => 0, 'Jan2' => 0, 'Jan3' => 0}
   ) 

    visit listings_path

    click_link_or_button("Add Listing")
  end

  it "shows a list of cart listings" do
    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")
  end

  it "can remove a listing from the cart" do
    visit cart_path

    click_link_or_button("Remove Listing")

    within("#flash_notice") do
      expect(page).to have_content("Bacon Maple Crunch removed from cart")
    end
  end

  it "persists from logged out state to logged in state" do

    user = create(:user)
    login_as(user)
    visit cart_path

    expect(page).to have_content("Bacon Maple Crunch")

    click_link_or_button("Checkout")

    expect(page).to have_content("Order successfully submitted")
  end

end

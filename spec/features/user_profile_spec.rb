require 'rails_helper'

RSpec.describe "Authenticated User profile" do
  let!(:user) { create(:user) }
  before(:each) { set_current_user(user) }

  it "submits an order when cart is checked out" do
    listing1 = create(:listing)
    listing1.pictures.create(url: "default-image")
    visit listing_path(listing1)
    fill_in("listing[end_date]", with: "11/07/2015")
    fill_in("listing[start_date]", with: "11/01/2015")
    click_link_or_button("Add to Itinerary")

    visit cart_path
    expect(page).to have_content("Bacon Maple Crunch")
    click_link_or_button("Book Itinerary")
    visit orders_path

    expect(page).to have_content("Cheese Toast")
  end

  xit "can click Order History link to be taken to Order History page" do
    visit root_path

    expect(page).to have_link("Order History")

    click_link_or_button("Order History")

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("#{user.username}'s Orders")
  end

  it "sees Order History" do
    user.orders.create(cart: {"1" => 1})
    create(:item, id: 1)

    visit orders_path

    expect(page).to have_content("Cheese Toast")
  end
end

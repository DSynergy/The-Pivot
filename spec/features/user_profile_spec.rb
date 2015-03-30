require 'rails_helper'

RSpec.describe "Authenticated User profile" do
  let!(:user) { create(:user) }
  before(:each) { set_current_user(user) }

  it "submits an order when cart is checked out" do
    set_cart
    visit cart_path

    click_link_or_button("Checkout")
    visit orders_path

    expect(page).to have_content("Cheese Toast")
  end

  it "can click Order History link to be taken to Order History page" do
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

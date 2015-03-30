require 'rails_helper'

RSpec.describe "Cart" do
  before(:each) do
    create(:item)

    visit items_path

    click_link_or_button("Add to Cart")
  end

  it "shows a list of cart items" do
    visit cart_path

    expect(page).to have_content("Cheese Toast 1")
  end

  it "can remove an item from the cart" do
    visit cart_path

    click_link_or_button("Remove Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast removed from cart")
    end
  end

  it "can increase an item's quantity in the cart" do
    visit cart_path

    click_link_or_button("Add Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast added to cart")
    end
  end

  it "persists from logged out state to logged in state" do
    visit cart_path

    click_link_or_button("Add Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast added to cart")
    end

    user = create(:user)
    login_as(user)
    visit cart_path

    expect(page).to have_content("Cheese Toast")

    click_link_or_button("Checkout")

    expect(page).to have_content("Order successfully submitted")
  end

end

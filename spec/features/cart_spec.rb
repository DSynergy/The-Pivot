require 'rails_helper'

RSpec.describe "Cart" do
  before(:each) do
    listing =  create(:listing, available_dates: "{2=>3}")
    listing.categories.create(name: "home")
    visit listings_path

    click_link_or_button("Bacon Maple Crunch")
    fill_in "from-date", :with => "01/01/2015"
    fill_in "to-date", :with => "01/01/2015"
    click_link_or_button("Add to Itinerary")
  end

  it "shows a list of cart items" do
    visit cart_path
    expect(page).to have_content("Cheese Toast 1")
  end

  xit "can remove an item from the cart" do
    visit cart_path

    click_link_or_button("Remove Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast removed from cart")
    end
  end

  xit "can increase an item's quantity in the cart" do
    visit cart_path

    click_link_or_button("Add Item")

    within("#flash_notice") do
      expect(page).to have_content("Cheese Toast added to cart")
    end
  end

  xit "persists from logged out state to logged in state" do
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

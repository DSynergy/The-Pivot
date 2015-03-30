require 'rails_helper'

RSpec.describe "Item show" do
  let(:item) { create(:item) }

  it "displays item title" do
    visit item_path(item)
    within('#item-title') do
      expect(page).to have_content("Cheese Toast")
    end
  end

  it "displays item description" do
    visit item_path(item)
    within("#item-description") do
      expect(page).to have_content("Super cheesy bread food")
    end
  end

  it "display items price" do
    visit item_path(item)
    within("#item-price") do
      expect(page).to have_content("3.00")
    end
  end

  it "displays a custom picture" do
    visit item_path(item)
    within(".default-pic") do
      expect(page).to have_css("img")
    end
  end

  it "has a link to add item to cart" do
    visit item_path(item)

    expect(page).to have_button("Add to Cart")

    click_link_or_button("Add to Cart")

    expect(current_path).to eq(item_path(item))
    expect(page).to have_selector("#flash_notice")
  end

  context "when a user clicks an item from a previous order thats been retired" do
    it "notes if item is retired" do
      user = create(:user)
      item = Item.create(name: "apple toast", description: "blah", price: 2.00, retired: true)
      user.orders.create(status: 0, cart: { item.id => 1 })

      login_as(user)
      visit orders_path
      click_link_or_button("apple toast")
      within("#retired-item") do
        expect(page).to have_content("#{item.name} has been retired from the menu")
      end
      expect(page).not_to have_content("Add to Cart")
    end
  end

end

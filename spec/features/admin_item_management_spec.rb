require 'rails_helper'

RSpec.describe "Admin Item Management" do
  let(:admin) { create(:admin) }
  let!(:listing) { create(:listing) }

  before(:each) do
    login_as(admin)
    click_link_or_button("Manage Items")
  end

  it "has a link to create an listing" do
    click_link_or_button("Create Item")

    expect(current_path).to eq(new_admin_listing_path)
  end

  it "fills in new listing form to create a new listing" do
    click_link_or_button("Create Item")
    fill_in("listing[name]", with: "Beer Toast")
    fill_in("listing[description]", with: "Soggy, beery toast")
    fill_in("listing[price]", with: 3.50)
    click_link_or_button("Create Toast")

    expect(Item.last.name).to eq("Beer Toast")
  end

  it "cannot create an listing that already exists" do
    click_link_or_button("Create Item")
    2.times do
      fill_in("listing[name]", with: "Beer Toast")
      fill_in("listing[description]", with: "Soggy, beery toast")
      fill_in("listing[price]", with: 3.50)
      click_link_or_button("Create Toast")
    end

    expect(page).to have_content("That toast already exists")
  end

    it "has ability to update an listing" do
      click_link_or_button("Cheese Toast")
      expect(current_path).to eq(edit_admin_listing_path(listing))
      expect(listing.price).to eq(3.0)
      fill_in("listing[price]", with: 3.50)
      click_link_or_button("Update")
      expect(current_path).to eq(admin_listings_path)
      expect(page).to have_content("Successfully Updated")
    end

    it "cannot update an listing to match an existing listing's attributes" do
      listing_2 = create(:listing, name: "Nacho Toast", description: "not your toast", price: 3.00)
      click_link_or_button("Cheese Toast")

      expect(current_path).to eq(edit_admin_listing_path(listing))
      expect(listing.price).to eq(3.0)

      fill_in("listing[name]", with: "Nacho Toast")
      fill_in("listing[description]", with: "Soggy, beery toast")
      fill_in("listing[price]", with: 3.50)
      click_link_or_button("Update")

      expect(page).to have_content("Name has already been taken")
    end

    it "has the ability to activate an listing" do
      listing.retired = true
      click_link_or_button("Cheese Toast")
      within("#false") do
        choose("listing[retired]")
      end
      click_link_or_button("Update")
      expect(current_path).to eq(admin_listings_path)
      expect(page).to have_content("Successfully Updated")
    end

    it "has ability to delete an listing" do
      click_link_or_button("Cheese Toast")
      click_link_or_button("Delete Item")
      expect(current_path).to eq(admin_listings_path)
      expect(page).to have_content("Item Deleted")
    end
end

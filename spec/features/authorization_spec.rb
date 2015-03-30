require 'rails_helper'

RSpec.describe "User Authorization" do
  let(:user_1) { create(:user, username: "Sally") }
  let(:user_2) { create(:user, username: "Billy", email_address: "billbob@example.com") }
  let!(:item_1) { create(:item, id: 1) }
  let!(:item_2) { create(:item, id: 2, name: "Beer Toast") }

  before(:each) do
    user_1.orders.create(cart: {"1" => 3, "2" => 4})
    user_2.orders.create(cart: {"1" => 2})
  end

  context "when logged in as a Default User" do

    it "sees personal order history" do
      login_as(user_1)

      visit orders_path

      expect(page).to have_content("Sally's Orders")
      expect(page).to have_content("$21.00")
    end

    it "does not see another user's order history" do
      login_as(user_1)

      visit orders_path

      expect(page).to_not have_content("Billy's Orders")
    end

    it "cannot visit any admin paths" do
      login_as(user_1)

      visit admin_path

      expect(page).to have_content("Unauthorized. Access Denied")
      expect(current_path).to eq(root_path)

      visit admin_categories_path

      expect(page).to have_content("Unauthorized. Access Denied")
      expect(current_path).to eq(root_path)
    end

  end

  context "when not logged in" do

    it "the user is prompted to log in if they visit the orders path" do
      visit orders_path

      expect(page).to have_content("You must be logged in to view this page")
      expect(current_path).to eq(login_path)
    end

    it "the user is told to log in if they visit an admin path" do
      visit admin_path

      expect(page).to have_content("You must be logged in to view this page")
      expect(current_path).to eq(login_path)
    end

  end

end

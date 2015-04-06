require 'rails_helper'

RSpec.describe 'User login/logout spec' do
  let!(:user) { create(:user) }

  context "when logged out" do

    it "can login with valid credentials" do
      visit root_path

      click_link_or_button("Log in")

      expect(current_path).to eq(login_path)

      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")

      click_link_or_button("Submit")

      within("#flash_notice") do
        expect(page).to have_content("Successfully logged in as #{user.username}")
      end
    end

    it "cannot login with invalid credentials" do
      visit root_path
      click_link_or_button("Log in")
      fill_in("session[username]", with: "Richard")
      fill_in("session[password]", with: "beiber")

      click_link_or_button("Submit")

      within("#flash_error") do
        expect(page).to have_content("Login failed")
      end
    end

    it "returns to previous url after logging in" do
      visit root_path
      click_on("Browse All Listings")
      click_on("Log in")
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      click_on("Submit")

      expect(page).to have_content("All Listings")
    end

  end

  context "when logged in" do
    it "sees a link logout on the page" do
      visit root_path
      click_on("Log in")
      
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      click_on("Submit")

      expect(page).to have_content("Log out")

      visit cart_path

      expect(page).to have_content("Log out")
    end
  end

    it "user can log out" do
      visit root_path
      click_on("Log in")
      
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      click_on("Submit")

      click_link_or_button("Log out")

      within("#flash_notice") do
       expect(page).to have_content("You have been logged out")
      end
      expect(current_path).to eq(root_path)
    end
  end

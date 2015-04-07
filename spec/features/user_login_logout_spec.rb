require 'rails_helper'

RSpec.describe 'User login/logout spec' do
  let!(:user) { create(:user) }

  context "when logged out" do

    it "can login with valid credentials" do
      visit root_path

      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")

      first(:css, "#small_submit_button").click

      within("#flash_notice") do
        expect(page).to have_content("Successfully logged in as #{user.username}")
      end
    end

    it "cannot login with invalid credentials" do
      visit root_path
      fill_in("session[username]", with: "Richard")
      fill_in("session[password]", with: "beiber")
first(:css, "#small_submit_button").click

      within("#flash_error") do
        expect(page).to have_content("Login failed")
      end
    end

    it "returns to previous url after logging in" do
      visit root_path
      click_on("Browse All Listings")
      click_on("Log In")
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      first(:css, "#small_submit_button").click

      expect(page).to have_content("All Listings")
    end
    
   xit "returns to url prior to login after entering invalid login info and having to re-enter login info" do
      visit root_path
      click_on("Browse All Listings")
      click_on("Log In")
      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "incorrect")
      first(:css, "#small_submit_button").click

      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      first(:css, "#login-form").click
      expect(page).to have_content("All Listings")
    end

  end

  context "when logged in" do
    it "sees a link logout on the page" do
      visit root_path

      fill_in("session[username]", with: "Sally")
      fill_in("session[password]", with: "password")
      first(:css, "#small_submit_button").click

      expect(page).to have_content("Log out")
      visit cart_path
      expect(page).to have_content("Log out")
    end
  end

  it "user can log out" do
    visit root_path

    fill_in("session[username]", with: "Sally")
    fill_in("session[password]", with: "password")
    first(:css, "#small_submit_button").click
    click_link_or_button("Log out")

      within("#flash_notice") do
       expect(page).to have_content("You have been logged out")
      end
      expect(current_path).to eq(root_path)
    end
  end

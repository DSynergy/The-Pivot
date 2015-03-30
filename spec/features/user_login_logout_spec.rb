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

      click_link_or_button("Check In")

      within("#flash_notice") do
        expect(page).to have_content("Successfully logged in as #{user.username}")
      end
    end

    it "cannot login with invalid credentials" do
      visit root_path
      click_link_or_button("Log in")
      fill_in("session[username]", with: "Richard")
      fill_in("session[password]", with: "beiber")

      click_link_or_button("Check In")

      within("#flash_error") do
        expect(page).to have_content("Login failed")
      end
    end

  end

  context "when logged in" do
    it "sees a link logout on the page" do
      login_as(user)
      expect(page).to have_link("Log out")

      visit cart_path

      expect(page).to have_link("Log out")
    end
  end

  it "user can log out" do
    login_as(user)
    click_link_or_button("Log out")

    within("#flash_notice") do
      expect(page).to have_content("You have been logged out")
    end
    expect(current_path).to eq(root_path)
  end

end

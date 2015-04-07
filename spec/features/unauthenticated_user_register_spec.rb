require 'rails_helper'

RSpec.describe 'Unauthenticated user register spec' do
    context "when logged out" do

      it "I can register with valid data and I am automatically signed in" do
        visit root_path

        fill_in("user[username]", with: "Sally")
        fill_in("user[email_address]", with: "sadsal@example.com")
        fill_in("user[display_name]", with: "SuperStarSally123")
        fill_in("user[password]", with: "password")

        first(:css, "#small_submit_button-register").click

        within("#flash_notice") do
          expect(page).to have_content("Hello SuperStarSally123! Welcome to TravelHome!")
        end
        expect(page).to_not have_content("Log In")
      end

    end

end

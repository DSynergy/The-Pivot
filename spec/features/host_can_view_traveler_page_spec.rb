require 'rails_helper'

RSpec.describe "host page links" do
  let!(:user) { create(:user) }

  it "can view traveler page from link on host page" do
    sign_in(:user)

    click_on("View Host Page")

    expect(page).to have_content("View Traveler Page")
    click_on("View Traveler Page")
    expect(page).to have_content("View Host Page")
  end

  def sign_in(user)
    visit root_path
    click_on("Log in")
    fill_in("session[username]", with: "Sally")
    fill_in("session[password]", with: "password")
    click_on("Submit")
  end
end

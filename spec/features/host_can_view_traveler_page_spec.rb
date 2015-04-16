require 'rails_helper'

RSpec.describe "host page links" do
  let!(:user) { create(:user) }

  it "can view traveler page from link on host page" do
    sign_in(user)
    click_on("Host Page")

    expect(page).to have_content("Traveler Page")
    click_on("Traveler Page")
    expect(page).to have_content("Host Page")
  end

end

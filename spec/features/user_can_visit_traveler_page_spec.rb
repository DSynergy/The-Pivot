require 'rails_helper'

RSpec.describe "user visit traveler page spec" do
  let!(:user) { create(:user) }

  it "can view traveler page" do
    sign_in(:user)
    expect(page).to have_content("Traveler Page")
    click_link_or_button("Traveler Page")
    expect(page).to have_content("Welcome #{user.display_name ? user.display_name : user.username}")
  end

end

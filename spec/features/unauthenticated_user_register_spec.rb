require 'rails_helper'

RSpec.describe 'Unauthenticated user register spec' do

  it "can register" do
    visit root_path

    click_on("Sign Up")
    expect(current_path).to eq(new_user_path)

    fill_in "user[username]", with: "new_user"
    fill_in "user[email_address]", with: "new_user@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[display_name]", with: "new"
    click_on("Submit")
    user = User.last

    expect(current_path).to eq(root_path)
    expect(user.username).to eq("new_user")
    expect(user.email_address).to eq("new_user@example.com")
    expect(user.display_name).to eq("new")
  end

  it "can pick available dates for reservation and add to cart" do
    listing = create(:listing, available_dates: '{{1=>1, 1=>2, 1=>3} => 0}')
    listing.categories.create(name: "house")
    visit listing_path(listing)

    click_link_or_button(20)
    click_on(23)
    click_on("Add to Itinerary")

    expect(page).to have_content("Successfully added to Itinerary: January 21-23")
  end
end

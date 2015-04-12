require 'rails_helper'

RSpec.describe "Listing search" do
  it "finds one listing in search" do
    listing = create(:listing, start_date: "08/10/2015", end_date:"08/12/15")
    visit root_path
    fill_in('search', with: "#{listing.city}")
    find("#search-form button").click
    expect(page).to have_content("#{listing.title}")
  end
end

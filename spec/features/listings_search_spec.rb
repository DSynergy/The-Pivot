require 'rails_helper'

RSpec.describe "Listing search" do
  it "finds one listing in search" do
    listing = create(:listing, available_dates: "{1=>2, 1=>4}")
    visit root_path
    fill_in('search', with: "#{listing.title}")
    expect(page).to have_content("#{listing.title}")
  end
end

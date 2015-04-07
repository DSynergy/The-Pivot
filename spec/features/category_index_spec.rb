require 'rails_helper'

RSpec.describe "Browse by Category" do
  xit "shows a list of Items by Category" do
    listing = create(:listing)
    listing.categories.create(name: "house")
    visit root_path
    click_link_or_button("Entree")

    expect(current_path).to eq(category_path(category))
    expect(page).to have_link("Cheese Toast")
  end

end

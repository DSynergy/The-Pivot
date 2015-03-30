require 'rails_helper'

RSpec.describe "Browse by Category" do
  it "shows a list of Items by Category" do
    category = create(:category)
    item = create(:item)
    category.items << item

    visit root_path
    click_link_or_button("Entree")

    expect(current_path).to eq(category_path(category))
    expect(page).to have_link("Cheese Toast")
  end

end

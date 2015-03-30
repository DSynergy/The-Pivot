require 'rails_helper'

RSpec.describe "Admin Category Add" do
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }

  before(:each) do
    login_as(admin)
    click_link_or_button("Manage Categories")
  end

  it "can click a button to be taken to a form" do
    click_link_or_button("Add Category")
    expect(page).to have_content("Add a New Category of Toast")
    expect(current_path).to eq(new_admin_category_path)
  end

  it "can fill in a form to add a new category" do
    click_link_or_button("Add Category")
    expect(current_path).to eq(new_admin_category_path)

    fill_in("category[name]", with: "Tea Time")
    click_link_or_button("Create Category")

    expect(Category.last.name).to eq("Tea Time")
    expect(page).to have_content("Category Created!")
  end

  it "cannot create a category that already exists" do
    click_link_or_button("Add Category")

    2.times do
      fill_in("category[name]", with: "Midnight Supper")
      click_link_or_button("Create Category")
    end
    expect(page).to have_content("That Category Already Exists")
  end

end

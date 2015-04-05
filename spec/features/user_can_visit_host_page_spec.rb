require 'rails_helper'

RSpec.describe "user visit host page spec" do
  let!(:user) { create(:user) }

  it "can view host page" do
    sign_in(:user)
    click_on("View Host Page")
    
    expect(page).to have_content("Host Page: #{user.username}")
  end

  def sign_in(user)
    visit root_path
    click_on("Log in")
    fill_in("session[username]", with: "Sally")
    fill_in("session[password]", with: "password")
    click_on("Submit")
  end
end

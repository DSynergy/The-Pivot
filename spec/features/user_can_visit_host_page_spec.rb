require 'rails_helper'

RSpec.describe "user visit host page spec" do
  let!(:user) { create(:user) }

  it "can view host page" do
    sign_in(:user)
    click_on("Host Page")
    expect(page).to have_content("Host Page: #{user.display_name ? user.display_name : user.username}")
  end

end

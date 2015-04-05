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
end

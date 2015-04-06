def login_as(user)
  visit root_path
  click_on("Log in")

  fill_in "session[username]", with: user.username
  fill_in "session[email_address]", with: user.email_address
  fill_in "session[password]", with: user.password

  click_link_or_button "Submit"
end

def set_current_user(user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end

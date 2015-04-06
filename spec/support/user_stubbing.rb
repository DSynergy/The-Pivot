def login_as(user)
  visit root_path

  first(:css, ".login-username").set(user.username)
  first(:css, ".login-email").set(user.email_address)
  first(:css, ".login-password").set(user.password)

  first(:css, "#small_submit_button").click
end

def set_current_user(user)
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
end

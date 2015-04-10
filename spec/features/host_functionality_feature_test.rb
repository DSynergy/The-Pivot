require 'rails_helper'

RSpec.describe "host functionality" do

  context "when the host is signed in and on their page" do

    it "can create a listing" do
      user = create(:user)
      sign_in(user)
      visit host_path(user)
      click_on("Add listing")
      expect(current_path).to eq(new_host_listing_path(slug: user.username))
    end

    it "can edit a listing" do
    end
  end
end



# 
# A host must confirm a visitor's booking request
#
# As a host, I can edit the listing details.
#
# As a host, I can retire a listing.
#
#   end
# end
#
#
#

#As a user, when I reserve a listing, I receive an email notification with the details of my reservation.
#As a user, when a host confirms the reservation, I receive an email notification.
#As a host, when a reservation is requested, I receive an email notification.

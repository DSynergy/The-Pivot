require 'rails_helper'

RSpec.describe "host functionality" do

  context "when the host is signed in and on their page" do

    it "can create a listing" do
      user = create(:user)
      sign_in(user)
      visit host_path(user)
      click_on("Add listing")
      fill_in "listing[title]", with: "New Listing"
      fill_in "listing[description]", with: "New listing details"
      fill_in "listing[price]", with: 5000
      fill_in "listing[quantity_available]", with: 2
      fill_in "listing[people_per_unit]", with: 4
      fill_in "listing[street_address]", with: "123 new street"
      fill_in "listing[city]", with: "city"
      fill_in "listing[state]", with: "state"
      fill_in "listing[country]", with: "country"
      fill_in "listing[zipcode]", with: "12345"
      fill_in "listing[start_date]", with: "05/10/15"
      fill_in "listing[end_date]", with: "05/12/15"
      click_on("Submit New Listing")

      expect(page).to have_content("Listing saved!")
    end

    it "can edit a listing" do
      user = create(:user)
      sign_in(user)
      visit host_path(user)
      click_on("Add listing")
      fill_in "listing[title]", with: "New Listing"
      fill_in "listing[description]", with: "New listing details"
      fill_in "listing[price]", with: 5000
      fill_in "listing[quantity_available]", with: 2
      fill_in "listing[people_per_unit]", with: 4
      fill_in "listing[street_address]", with: "123 new street"
      fill_in "listing[city]", with: "city"
      fill_in "listing[state]", with: "state"
      fill_in "listing[country]", with: "country"
      fill_in "listing[zipcode]", with: "12345"
      fill_in "listing[start_date]", with: "05/10/15"
      fill_in "listing[end_date]", with: "05/12/15"
      click_on("Submit New Listing")
      click_on("Edit")
      expect(current_path).to eq(edit_host_listing_path(slug: user.username, id: Listing.last.id))
      fill_in "listing[title]", with: "Updated Title"
      click_on("Update Changes")
      
      expect(page).to have_content("Updated Title")
    end
  end
end



# 
# A host must confirm a visitor's booking request
#
# As a host, I can edit the listing details.

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

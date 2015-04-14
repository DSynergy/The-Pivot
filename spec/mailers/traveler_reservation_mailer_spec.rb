require "rails_helper"

RSpec.describe TravelerReservationMailer, type: :mailer do
  describe "reserve_listing_mailer" do
    let(:mail) { TravelerReservationMailer.reserve_listing_mailer }

    xit "renders the headers" do
      expect(mail.subject).to eq("Your Travel Home Booking")
      # expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["TravelHome.Turing@gmail.com"])
    end

    xit "renders the body" do
      expect(mail.body.encoded).to match("Hello <%= set_name(@traveler) %>, this is a courtesy email from Travel Home.

        You are currently booked for <%= @traveler.booking.first %>.

        The host has been notified of your booking for each listing you have reserved.
        You should hear back within 5 business days and will be notified via email.

        You can find more details on your travler's page: <%= link_to "traveler page", current_user %>.

        Thank you for using Travel Home.

        Have a safe journey!")
    end
  end

end

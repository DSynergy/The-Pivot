require "rails_helper"

RSpec.describe HostReservationRequestMailer, type: :mailer do
  describe "host_listing_email" do
    let(:mail) { HostReservationRequestMailer.host_listing_email }

    xit "renders the headers" do
      expect(mail.subject).to eq("Host listing email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    xit "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

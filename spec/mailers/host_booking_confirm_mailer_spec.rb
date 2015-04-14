require "rails_helper"

RSpec.describe HostBookingConfirmMailer, type: :mailer do
  describe "host_confirmation_email_to_traveler" do
    let(:mail) { HostBookingConfirmMailer.host_confirmation_email_to_traveler }

    it "renders the headers" do
      expect(mail.subject).to eq("Host confirmation email to traveler")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

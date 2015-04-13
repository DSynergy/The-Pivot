require "rails_helper"

RSpec.describe HostCancelMailer, type: :mailer do
  describe "host_cancels_email_to_traveler" do
    let(:mail) { HostCancelMailer.host_cancels_email_to_traveler }

    it "renders the headers" do
      expect(mail.subject).to eq("Host cancels email to traveler")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

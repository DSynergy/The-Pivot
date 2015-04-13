class HostCancelMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.host_cancel_mailer.host_cancels_email_to_traveler.subject
  #
  def host_cancels_email_to_traveler(reservation)
    @reservation = reservation
    @traveler = @reservation.user

    mail to: @traveler.email_address, subject: "Your host has canceled your reservation. :/"
  end
end

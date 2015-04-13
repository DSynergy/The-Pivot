class HostBookingConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.host_booking_confirm_mailer.host_confirmation_email_to_traveler.subject
  #
  def host_confirmation_email_to_traveler(reservation)
    @reservation = reservation
    @traveler = @reservation.user

    mail to: @traveler.email_address, subject: "Your host has confirmed your Travel Home reservation!"
  end
end

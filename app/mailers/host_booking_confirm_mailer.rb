class HostBookingConfirmMailer < ApplicationMailer

  def host_confirmation_email_to_traveler(reservation)
    @reservation = reservation
    @traveler = @reservation.user
    @host = @reservation.listing.user

    mail to: @traveler.email_address, subject: "Your host has confirmed your Travel Home reservation!"
  end
end

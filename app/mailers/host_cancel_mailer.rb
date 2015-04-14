class HostCancelMailer < ApplicationMailer

  def host_cancels_email_to_traveler(reservation)
    @reservation = reservation
    @traveler = @reservation.user
    @host = @reservation.listing.user

    mail to: @traveler.email_address, subject: "Your host has canceled your reservation. :/"
  end
end

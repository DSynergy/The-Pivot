class HostReservationRequestMailer < ApplicationMailer

  def host_listing_email(reservation)
    @reservation = reservation
    @host = @reservation.listing.user

      #   As a host, when a reservation is requested, I receive an email notification.

      mail to: @host.email_address, subject: "You have received a reservation from one of our travelers!"
  end
end

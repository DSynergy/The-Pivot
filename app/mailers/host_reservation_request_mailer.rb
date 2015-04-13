class HostReservationRequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.host_reservation_request_mailer.host_listing_email.subject
  #
  def host_listing_email(reservation)
    @reservation = reservation
    @host = @reservation.listing.user

      #   As a host, when a reservation is requested, I receive an email notification.

      mail to: @host.email_address, subject: "You have received a reservation from one of our travelers!"
  end
end

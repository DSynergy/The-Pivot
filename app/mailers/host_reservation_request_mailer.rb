class HostReservationRequestMailer < ApplicationMailer

  def host_listing_email(reservations)
    reservations.each do |reservation|
      @reservation = reservation
      @host = @reservation.listing.user
      @traveler = @reservation.user
    end
    mail to: @host.email_address, subject: "You have received a reservation from one of our travelers!"
  end
end

# Preview all emails at http://localhost:3000/rails/mailers/host_reservation_request_mailer
class HostReservationRequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/host_reservation_request_mailer/host_listing_email
  def host_listing_email
    reservation = Booking.last.reservations.last
    HostReservationRequestMailer.host_listing_email(reservation)
  end

end

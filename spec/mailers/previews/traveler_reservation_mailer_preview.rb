# Preview all emails at http://localhost:3000/rails/mailers/traveler_reservation_mailer
class TravelerReservationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/traveler_reservation_mailer/reserve_listing_mailer
  def reserve_listing_mailer
    booking = Booking.maximum
    TravelerReservationMailer.reserve_listing_mailer(booking)
  end

end

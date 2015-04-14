class TravelerReservationMailer < ApplicationMailer

  def reserve_listing_mailer(booking)
    @booking = booking
    @traveler = @booking.user

    mail to: @traveler.email_address, subject: "Your Travel Home Booking!"
  end

end

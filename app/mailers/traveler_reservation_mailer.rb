class TravelerReservationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.traveler_reservation_mailer.reserve_listing_mailer.subject
  #
  def reserve_listing_mailer(booking)
    @booking= booking
    @traveler = @booking.user


    mail to: @traveler.email_address, subject: "Your Travel Home Booking!"

  end



end

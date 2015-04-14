# Preview all emails at http://localhost:3000/rails/mailers/host_cancel_mailer
class HostCancelMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/host_cancel_mailer/host_cancels_email_to_traveler
  def host_cancels_email_to_traveler
    reservation = Booking.last.reservations.last
    HostCancelMailer.host_cancels_email_to_traveler(reservation)
  end

end

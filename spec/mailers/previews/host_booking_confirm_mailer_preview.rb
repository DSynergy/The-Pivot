# Preview all emails at http://localhost:3000/rails/mailers/host_booking_confirm_mailer
class HostBookingConfirmMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/host_booking_confirm_mailer/host_confirmation_email_to_traveler
  def host_confirmation_email_to_traveler
    HostBookingConfirmMailer.host_confirmation_email_to_traveler
  end

end

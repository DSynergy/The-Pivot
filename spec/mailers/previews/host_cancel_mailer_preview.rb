# Preview all emails at http://localhost:3000/rails/mailers/host_cancel_mailer
class HostCancelMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/host_cancel_mailer/host_cancels_email_to_traveler
  def host_cancels_email_to_traveler
    HostCancelMailer.host_cancels_email_to_traveler
  end

end

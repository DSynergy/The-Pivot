class Users::ReservationsController < ApplicationController
  before_action :set_reservation

  def update
    @reservation.update_attributes(status: 1)
    HostBookingConfirmMailer.host_confirmation_email_to_traveler(@reservation).deliver_now
    redirect_to host_path(current_user)
  end

  def destroy
    @reservation.update_attributes(status: 2)
    HostCancelMailer.host_cancels_email_to_traveler(@reservation).deliver_now
    redirect_to host_path(current_user)
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

end

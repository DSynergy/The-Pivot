class Users::BookingsController < ApplicationController
  before_action :redirect_to_login_if_not_logged_in, only: [:index]

  def index
    @bookings = current_user.bookings
  end

  def create
    cart = @cart.content
    Booking.generate_booking(current_user, cart)
    session[:cart]={}
    redirect_to traveler_path(current_user),
      notice: "Order successfully submitted!"
  end

end

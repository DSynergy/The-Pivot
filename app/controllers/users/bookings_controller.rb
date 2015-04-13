class Users::BookingsController < ApplicationController
  before_action :redirect_to_login_if_not_logged_in, only: [:index]

  def create
    cart = @cart.content
    booking = current_user.bookings.generate_reservations(current_user, cart, params[:trip_name])
    TravelerReservationMailer.reserve_listing_mailer(booking).deliver_now
    session[:cart]={}
    redirect_to traveler_path(current_user),
      notice: "Your itinerary has been successfully booked. Happy travels!"
  end

  def index
    redirect_to traveler_path(current_user)
  end

end

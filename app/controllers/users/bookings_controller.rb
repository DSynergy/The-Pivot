class Users::BookingsController < ApplicationController
  before_action :redirect_to_login_if_not_logged_in, only: [:index]

  def create
    cart = @cart.content
    current_user.bookings.create(trip_name: params[:trip_name]).generate_reservations(cart)
    @booking = Booking.last
    TravelerReservationMailer.reserve_listing_mailer(@booking).deliver_now
    @booking.reservations.each do |reservation|
      HostReservationRequestMailer.host_listing_email(reservation).deliver_now
    end
    session[:cart]={}
    redirect_to traveler_path(current_user),
      notice: "Your itinerary has been successfully booked. Happy travels!"
  end

  def index
    redirect_to traveler_path(current_user)
  end

end

class Booking < ActiveRecord::Base
  belongs_to :user #traveler
  has_many :reservations
  has_many :listings, through: :reservations


  def self.generate_reservations(current_user, cart, trip_name)
    booking = Booking.create(trip_name: trip_name, user_id: current_user.id)
    cart.each do |key, value|
      booking.reservations.create(listing_id: key, start_date: value.first,
      end_date: value.last, user_id: current_user.id, status: 0)
    end
  end

end

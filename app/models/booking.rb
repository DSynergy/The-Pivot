class Booking < ActiveRecord::Base
  belongs_to :user #traveler
  has_many :reservations
  has_many :listings, through: :reservations


  def generate_reservations(cart)
    cart.each do |listing, dates|
      create_reservation(listing, dates)
    end
  end

  def calculate_total
    self.reservations.reduce(0) { |sum, reservation| sum + reservation.total_price }
  end

  private

  def create_reservation(listing, dates)
    self.reservations.create(listing_id: listing, start_date: dates.first,
    end_date: dates.last, user_id: user_id, status: 0)
  end

end

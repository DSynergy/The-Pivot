class Reservation < ActiveRecord::Base
  belongs_to :booking
  belongs_to :listing
  belongs_to :user #traveler
  enum status: %w(pending completed cancelled)
  scope :pending, -> { where(status: 0)}
  scope :completed, -> { where(status: 1) }
  scope :cancelled, -> { where(status: 2) }

   def total_price
     listing.price
   end

   def pending?
     status == "pending"
   end

   def past?
     status == "completed"
   end

   def cancelled?
     status == "cancelled"
   end

   def traveler
     self.user.username
   end
end

  # def total_days_per_booking
  #   cart.each { |listing_id, dates| cart[listing_id] = dates.count('=') }.values.reduce(:+)
  # end
  #
  # def parse_listings
  #   cart.reduce({}) do |hash, (listing_id, dates)|
  #     hash[Listing.find(listing_id)] = dates
  #     hash
  #   end
  # end
  #
  #
  # def title_of_listing
  #   cart.keys
  # end
  #
  # def dates_of_listing
  #   cart.values
  # end
  #
  #
  # def self.sort_by_status(status)
  #   case status
  #   when nil
  #     Booking.all
  #   when '0'
  #     Booking.pending
  #   when '1'
  #     Booking.completed
  #   when '2'
  #     Booking.cancelled
  #   end

=begin
    def pending?
      status == "pending"
    end

    def total
      listings_with_quantity.reduce(0) do |total, (listing, quantity)|
        total += line_listing_total(listing, quantity)
      end
    end

=end

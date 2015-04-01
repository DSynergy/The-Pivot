class Booking < ActiveRecord::Base
  belongs_to :user
  enum status: %w(pending completed cancelled)
  scope :pending, -> { where(status: 0)}
  scope :completed, -> { where(status: 1) }
  scope :cancelled, -> { where(status: 2) }

=begin
  def pending?
    status == "pending"     
  end

  def line_item_total(item, quantity)
    listing.price * quantity
  end

  def items_with_quantity
    format_quantity
    cart.reduce({}) do |hash, (id, quantity)|
      hash[Item.find(id)] = quantity
      hash
    end
  end

  def total
    items_with_quantity.reduce(0) do |total, (item, quantity)|
      total += line_item_total(item, quantity)
    end
  end

  def self.generate_booking(user, cart)
    create(user_id: user.id, cart: cart)
  end
=end

  def self.sort_by_status(status)
    case status
    when nil
      Booking.all
    when '0'
      Booking.pending
    when '1'
      Booking.completed
    when '2'
      Booking.cancelled
    end
  end

  private

  def format_quantity
    cart.each { |listing_id, dates| cart[listing_id] = dates.size }
  end

end

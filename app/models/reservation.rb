class Reservation < ActiveRecord::Base
  belongs_to :booking
  belongs_to :listing
  belongs_to :user #traveler
  enum status: %w(pending completed cancelled)
  scope :pending, -> { where(status: 0)}
  scope :completed, -> { where(status: 1) }
  scope :cancelled, -> { where(status: 2) }

  def total_price
    listing.price * date_range
  end

  def date_range
    (Date.strptime(end_date, '%m/%d/%Y') - Date.strptime(start_date, '%m/%d/%Y')).to_i
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

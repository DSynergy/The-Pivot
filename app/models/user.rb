class User < ActiveRecord::Base
  before_validation :format_credit_card
  validates :username, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_blank: true
  validates_format_of :email_address, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, on: :create
  validates_format_of :credit_card, with: /\A\d{15,16}\z/, on: :create, allow_blank: true

  has_many :listings #host
  has_many :bookings #traveler
  has_many :reservations #traveler
  has_secure_password

  mount_uploader :avatar, ProfileUploader

  enum role: %w(active admin inactive)

  def format_credit_card
    if credit_card
      credit_card.gsub!(/\D/,'')
    end
  end

  def reservations_awaiting_approval
    reservations = self.listings.collect do |listing|
      listing.pending_reservations
    end
    reservations.flatten
  end

  def past_reservations
    reservations = self.listings.collect do |listing|
      listing.past_reservations
    end
    reservations.flatten
  end

  def cancelled_reservations
    reservations = self.listings.collect do |listing|
      listing.cancelled_reservations
    end
    reservations.flatten
  end

end

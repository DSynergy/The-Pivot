class Booking < ActiveRecord::Base
  belongs_to :user #traveler
  has_many :reservations
  has_many :listings, through: :reservations



end

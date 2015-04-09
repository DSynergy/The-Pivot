class Listing < ActiveRecord::Base
  validates :title, :description, :price, :available_dates,
            :quantity_available, presence: true
  validates :title, uniqueness: true
  validates :price, :quantity_available, numericality: {greater_than: 0}
  validates :description, length: { maximum: 300 }
  has_many :listing_categories
  has_many :categories, through: :listing_categories
  has_many :pictures
  has_many :reservations
  has_many :bookings, through: :reservations
  scope :active, -> { where(status: 0)}
  scope :retired, -> { where(status: 1) }

  def retired
    status == 1
  end

  def self.search(query)
      where("city like ?", "%#{query}%")
  end

  def available_count
    available_dates.select {|key| available_dates[key].to_i == 0 }.count
  end

  def available_days
    available_dates.select {|key| available_dates[key].to_i == 0 }.keys
  end

end

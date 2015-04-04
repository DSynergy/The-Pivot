class Listing < ActiveRecord::Base
  validates :title, :description, :price, :available_dates,
            :quantity_available, presence: true
  validates :title, uniqueness: true
  validates :price, :quantity_available, numericality: {greater_than: 0}
  validates :description, length: { maximum: 300 }
  has_many :listing_categories
  has_many :bookings
  has_many :categories, through: :listing_categories
  has_many :pictures
  scope :active, -> { where(status: 0)}
  scope :retired, -> { where(status: 1) }

   def retired
     status == 1
   end
  #
  # def active
  #   status == 0
  # end

  def available_count
    available_dates.select {|key| available_dates[key].to_i == 0 }.count
  end

  def available_days
    available_dates.select {|key| available_dates[key].to_i == 0 }.keys
  end

end

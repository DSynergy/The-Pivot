class Listing < ActiveRecord::Base
  validates :title, :description, :price, :start_date, :end_date,
            :quantity_available, presence: true
  validates :title, uniqueness: true
  validates :price, :quantity_available, numericality: {greater_than: 0}
  validates :description, length: { maximum: 300 }
  has_many  :listing_categories
  has_many  :categories, through: :listing_categories
  has_many  :pictures
  has_many  :reservations
  has_many  :bookings, through: :reservations
  scope     :active, -> { where(status: 0)}
  scope     :retired, -> { where(status: 1) }
  belongs_to :user

  def retired
    status == 1
  end

  def self.search_locations(query)
      where("city LIKE ? OR state LIKE ? OR title LIKE ?", "%#{query}%","%#{query}%","%#{query}%")
  end

  def set_pictures(picture_params)
    if picture_params
      picture_params['avatar'].each do |pic|
        pictures.create(avatar: pic)
      end
    else
      pictures.create(avatar: "default_image")
    end
  end

  def pending_reservations
    reservations.select do |reservation|
      reservation.pending?
    end
  end

  def past_reservations
    reservations.select do |reservation|
      reservation.past?
    end
  end

  def cancelled_reservations
    reservations.select do |reservation|
      reservation.cancelled?
    end
  end

  def set_category(category_name)
    category = Category.find_by(name: category_name)
    self.categories = [category]
  end

end

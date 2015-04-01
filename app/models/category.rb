class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :listing_categories
  validates :name, uniqueness: true
  has_many :listings, through: :listing_categories
end

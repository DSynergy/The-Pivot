class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :item_categories
  validates :name, uniqueness: true
  has_many :items, through: :item_categories
end

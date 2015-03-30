class Item < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :description, length: { maximum: 300 }
  has_many :item_categories
  has_many :categories, through: :item_categories
  mount_uploader :avatar, AvatarUploader

  def self.active_items
    where(retired: false)
  end
end

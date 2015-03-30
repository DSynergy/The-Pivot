class ItemCategory < ActiveRecord::Base
  belongs_to :item
  belongs_to :category
  validates :item_id, uniqueness: {scope: :category_id}
end

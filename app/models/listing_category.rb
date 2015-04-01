class ListingCategory < ActiveRecord::Base
  belongs_to :listing
  belongs_to :category
  validates :listing_id, uniqueness: {scope: :category_id}
end

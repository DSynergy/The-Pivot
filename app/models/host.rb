class Host < ActiveRecord::Base
  accepts_nested_attributes_for :listings
end

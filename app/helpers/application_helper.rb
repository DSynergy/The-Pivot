module ApplicationHelper
  def helpers
    ActionController::Base.helpers
  end

  def parse_content(content)
    content.reduce({}) do |hash, (listing_id, dates)|
      hash[Listing.find(listing_id)] = dates
      hash
    end
  end

  def cache_key_for(model)
    prefix = model.to_s.downcase.pluralize
    count = model.count
    max_updated_at = model.maximum(:updated_at).utc.to_s(:number)

    "#{prefix}/all-#{count}-#{max_updated_at}"
  end

end

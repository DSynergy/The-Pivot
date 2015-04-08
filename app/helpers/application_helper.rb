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

end

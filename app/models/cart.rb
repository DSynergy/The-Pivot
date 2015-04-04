class Cart
  attr_accessor :content

  def initialize(content)
    @content = content || Hash.new
  end

  def listings_with_quantity
    listings = {}
    content.each { |id, dates| listings[Listing.find(id)] = dates }
    listings
  end

  def add_listing(listing_id, dates)
    content[listing_id] = dates
  end

  def remove_listing(listing_id)
    if content[listing_id] > 1
      content[listing_id] -= 1
    else
      content.delete(listing_id)
    end
  end

  private

  def format_quantity
    content.each { |listing, quantity| content[listing] = quantity.to_i }
  end

end

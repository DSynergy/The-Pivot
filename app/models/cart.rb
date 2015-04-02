class Cart
  attr_accessor :content

  def initialize(content)
    @content = content || Hash.new
  end

  def listings_with_quantity
    format_quantity
    listings = {}
    content.each { |id, quantity| listings[Listing.find(id)] = quantity }
    listings
  end

  def add_listing(listing_id)
    content[listing_id] ||= 0
    content[listing_id] += 1
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

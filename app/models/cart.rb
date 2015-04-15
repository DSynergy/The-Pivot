class Cart

  attr_accessor :content

  def initialize(content)
    @content = content || Hash.new
  end

  def listings_with_dates
    listings = {}
    content.each { |id, dates| listings[Listing.find(id)] = dates }
    listings
  end

  def add_listing(listing_id, start_date, end_date)
      content[listing_id] ||= []
      content[listing_id] << start_date
      content[listing_id] << end_date
  end

  def listings_per_cart
    content.keys.count
  end

  def remove_listing(listing_id)
    content.delete(listing_id)
  end

  def listing_date_range
    date_range = {}
    listings_with_dates.each do |listing, dates|
      date_range[listing]= date_range(dates.first, dates.last)
    end
    date_range
  end

  def total_price
    listing_date_range.reduce(0) { |sum, (listing,days)| sum + listing.price * days }
  end

  private

  def date_range(start_date, end_date)
    (Date.strptime(end_date, '%m/%d/%Y') - Date.strptime(start_date, '%m/%d/%Y')).to_i
  end

  def format_quantity
    content.each { |listing, quantity| content[listing] = quantity.to_i }
  end

end

def set_cart
  listing1 = create(:listing)
  listing1.pictures.create(url: "default-image")
  listing2 = create(:listing, title: "Banana Toast")
  listing2.pictures.create(url: "default-image")
  visit listing_path(listing1)
  click_link_or_button("Add to Itinerary")
  visit listing_path(listing2)
  click_link_or_button("Add to Itinerary")
end

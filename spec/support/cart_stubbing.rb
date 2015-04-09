def set_cart
  listing1 = create(:listing, available_dates: { 1=> {1=>4, 1=>7}})
  listing1.pictures.create(url: "default-image")
  listing2 = create(:listing, title: "Banana Toast", available_dates: {1=> {1=>23, 1=>24}})
  listing2.pictures.create(url: "default-image")
  visit listing_path(listing1)
  fill_in("listing[start_date]", with: "05/01/2015")
  fill_in("listing[end_date]", with: "05/02/2015")
  click_link_or_button("Add to Itinerary")
  visit listing_path(listing2)
  fill_in("listing[start_date]", with: "05/05/2015")
  fill_in("listing[end_date]", with: "05/06/2015")
  click_link_or_button("Add to Itinerary")
end

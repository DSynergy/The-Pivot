def set_cart
  item1 = create(:item)
  item2 = create(:item, name: "Banana Toast")
  visit item_path(item1)
  click_link_or_button("Add to Cart")
  visit item_path(item2)
  click_link_or_button("Add to Cart")
end

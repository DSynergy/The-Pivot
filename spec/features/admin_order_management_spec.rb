require 'rails_helper'

describe "Admin Order Management" do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let!(:item) { create(:item, id: 1) }
  let!(:order) { user.orders.create(cart: {"1"=> 2 }) }

  context "when on All Orders page" do

    before(:each) do
      login_as(admin)
      visit admin_orders_path
    end

    it "shows all orders" do
      expect(page).to have_content("all")
      expect(page).to have_content("less than a minute ago")
      expect(page).to have_link("#{order.id}")
    end

    it "links to a single order view" do
      click_link_or_button("#{order.id}")

      expect(page).to have_content(order.user.username)
    end

    it "shows all items and their information" do
      click_link_or_button(order.id.to_s)
      expect(page).to have_link("Cheese Toast")
      expect(page).to have_content("ordered")
      expect(page).to have_content(order.created_at)
      expect(page).to have_content(order.total)
    end

  end

  context "when on the Admin Order index page" do
    before(:each) do
      user.orders.create(id: 11, status:1, cart: {"1" => 3} )
      user.orders.create(id: 12, status:1, cart: {"1" => 3} )
      login_as(admin)

      visit admin_orders_path
    end

    it "shows orders by status selected from dropdown", js: true do
      select("ordered", from: "order_filter_status")

      within(".orders") do
        expect(page).to have_link("#{order.id}")
        expect(page).to_not have_link("12")
      end
    end

    it "states there are no orders if the status clicked on has no orders", js: true do
      select("cancelled", from: "order_filter_status")

      user.orders.each do |order|
        expect(page).to_not have_content(order)
      end
    end

  end

  context "when viewing an individual order" do
    before(:each) do
      login_as(admin)
      user.orders.create(id: 13, status:1, cart: {"1" => 3} )
      user.orders.create(id: 21, status:1, cart: {"1" => 3} )

      visit admin_orders_path
    end

    it "can change an order's status" do
      order_21 = user.orders.find(21)
      click_link_or_button("21")

      expect(current_path).to eq(admin_order_path(order_21))
      expect(order_21.status).to eq("paid")

      within("#completed") do
        choose("order[status]")
      end
      click_link_or_button("Submit")

      expect(page).to have_content("Success")
    end
  end
end

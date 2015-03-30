class OrdersController < ApplicationController
  before_action :redirect_to_login_if_not_logged_in, only: [:index]

  def index
    @orders = current_user.orders
  end

  def create
    cart = @cart.content
    Order.generate_order(current_user, cart)
    session[:cart]={}
    redirect_to cart_path,
      notice: "Order successfully submitted!"
  end

end

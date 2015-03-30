class Admin::OrdersController < ApplicationController
  layout "admin"
  before_action :redirect_to_login_if_not_logged_in
  before_action :is_admin?
  before_action :set_order, only: [:show, :update]

  def index
    status = params[:status]
    #@orders = Order.sort_by_status(status)
    @orders = Order.all
  end

  def show
  end

  def update
    if @order.update(order_params)
      flash[:notice] = "Success"
      redirect_to(:back)
    else
      redirect_to(:back)
      flash[:notice] = "Not a success"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :cart, :user_id)
  end

  def show_by_order_status
    Order.statuses.keys << "all"
  end

  helper_method :show_by_order_status
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :load_cart, :fetch_locations
  helper_method :load_cart, :set_name, :current_user, :current_cart, :redirect_to_login_if_not_logged_in, :fetch_locations

  private

  def fetch_locations
    @locations = Listing.all.pluck(:city, :state, :title).flatten
  end

  def load_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_cart
    @current_cart ||= session[:cart]
  end

  def set_name(user)
    user.display_name ? user.display_name : user.username
  end

  def redirect_to_login_if_not_logged_in
    if !current_user
      flash[:notice] = "You must be logged in to view this page"
      redirect_to login_path
    end
  end

end

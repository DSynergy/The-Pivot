class CartsController < ApplicationController
  def show
    @cart_contents = @cart.content
  end

  def create
    listing_id = params[:listing_id]
    @cart.add_listing(listing_id)
    session[:cart] = @cart.content
    listing = Listing.find(listing_id)

    flash[:notice] = "#{listing.title} added to cart"
    redirect_to(:back)
  end

  def destroy
    listing_id = params[:format]
    @cart.remove_listing(listing_id)
    listing = listing.find(listing_id)

    flash[:notice] = "#{listing.name} removed from cart"
    redirect_to cart_path
  end
end

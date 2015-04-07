class CartsController < ApplicationController
  def show
    @cart_contents = @cart.content
  end

  def destroy
    listing_id = params[:format]
    @cart.remove_listing(listing_id)
    listing = listing.find(listing_id)

    flash[:notice] = "#{listing.name} removed from cart"
    redirect_to cart_path
  end


  def create
    start_date = params[:listing][:start_date]
    end_date = params[:listing][:end_date]

    if start_date.nil? || end_date.nil?
      format.html { render action: "new" }
      format.json { render json: @cart.errors, status: :cannot_be_blank }
    else
      listing_id = params[:listing_id]
      @cart.add_listing(listing_id, [start_date, end_date])
      session[:cart] = @cart.content
      listing = Listing.find(listing_id)

      flash[:notice] = "#{listing.title} added to itinerary, #{start_date}-#{end_date}"
      redirect_to(:back)
    end
  end
end

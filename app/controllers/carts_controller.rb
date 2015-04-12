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

    start_date = (params[:listing][:start_date])
    end_date = params[:listing][:end_date]

    if start_date == "" || end_date == ""
      flash[:error] =  "dates cannot be blank"
      redirect_to(:back)
    else
      listing_id = params[:listing_id]
      listing = Listing.find(listing_id)
      @cart.add_listing(listing_id, [start_date, end_date])
      session[:cart] = @cart.content
      flash[:notice] = "#{listing.title} added to itinerary: #{Date.strptime(start_date, '%m/%d/%Y').strftime("%b %d %Y: %A")} - #{Date.strptime(end_date, '%m/%d/%Y').strftime("%b %d %Y: %A")}"
      redirect_to(:back)
    end
  end
end

class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    if params[:search]
      @listings = Listing.search(params[:search]).order("created_at DESC")
    else
      @listings = Listing.active.order('created_at DESC')
    end
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      params[:pictures]['avatar'].each do |a|
        @picture = @listing.pictures.create!(:avatar => a, :listing_id => @listing.id)
      end
      redirect_to host_path
    else
      render :new
    end
  end

    def show
    end

    private

    def set_listing
      @listing = Listing.find(params[:id])
    end

    def listing_params
      params.require(:listing).permit(:title, :price, :city, :state, :address, :start_date, :end_date, :quantity_available, :description, :private_bathroom, :country, :zipcode, pictures_attributes: [:id, :listing_id, :avatar])
    end
  end

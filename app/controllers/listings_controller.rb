class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    if params[:search] && params[:search] != ""
      @listings = Listing.active.where(city: params[:search]).order("created_at DESC")
    else
      @listings = Listing.active.paginate(page: params[:page], per_page: 5)
    end
  end

  def new
  end

  def create
  end

  def show
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

end

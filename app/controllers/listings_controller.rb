class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    if params[:search] && params[:search] != ""
      @listings = Listing.active.search_locations(params[:search])
    else
      @listings = Listing.active.paginate(page: params[:page], per_page: 10)
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

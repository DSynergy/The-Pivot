class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    if params[:search]
      @listings = Listing.search(params[:search]).order("created_at DESC")
    else
      @listings = Listing.active.order('created_at DESC')
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

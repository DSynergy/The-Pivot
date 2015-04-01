class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    @listings = Listing.active
  end

  def show

  end

  private

  def set_listing
    @listing = listing.find(params[:id])
  end
end

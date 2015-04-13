class ListingsController < ApplicationController
  before_action :set_listing, only: [:show]

  def index
    if params[:search]
      @listings = Listing.search(params[:search]).order("created_at DESC").paginate(:page => 5)
    else
#      @listings = Listing.active.order('created_at DESC').paginate(:page => 5)
      @listings = Listing.paginate(page: params[:page], per_page: 5)
    end
  end

  def new
  end

  def create
  end

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

end

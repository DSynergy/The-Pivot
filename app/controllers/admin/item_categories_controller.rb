class Admin::ItemCategoriesController < ApplicationController
  layout "admin"
  before_action :redirect_to_login_if_not_logged_in
  before_action :is_admin?
  before_action :set_category, only: [:new, :edit, :update, :destroy]
  before_action :set_listing, only: [:destroy]
  before_action :listing_options, :new

  def new
    @listing_category = ItemCategory.new(category_id: params[:category_id])
  end

  def edit
  end

  def create
    @listing_category = ItemCategory.new(listing_category_params)
    category = Category.find(@listing_category.category_id)

    if @listing_category.save
      flash[:notice] = "Category updated!"
      redirect_to admin_category_path(category)
    else
      flash[:notice] = "Item already exists in this Category"
      redirect_to(:back)
    end
  end

  def update
  end

  def destroy
    @listing.categories.delete(@category)
    flash[:notice] = "#{@listing.name} removed from category"

    redirect_to admin_category_path(@category)
  end

  private

  def listing_category_params
    params.require(:listing_category).permit(:category_id, :listing_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_listing
    @listing = Item.find(params[:listing_id])
  end

  def listing_options
    @listing_options = Item.all.map { |listing| [listing.name, listing.id] }
  end
end

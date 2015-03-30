class Admin::ItemCategoriesController < ApplicationController
  layout "admin"
  before_action :redirect_to_login_if_not_logged_in
  before_action :is_admin?
  before_action :set_category, only: [:new, :edit, :update, :destroy]
  before_action :set_item, only: [:destroy]
  before_action :item_options, :new

  def new
    @item_category = ItemCategory.new(category_id: params[:category_id])
  end

  def edit
  end

  def create
    @item_category = ItemCategory.new(item_category_params)
    category = Category.find(@item_category.category_id)

    if @item_category.save
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
    @item.categories.delete(@category)
    flash[:notice] = "#{@item.name} removed from category"

    redirect_to admin_category_path(@category)
  end

  private

  def item_category_params
    params.require(:item_category).permit(:category_id, :item_id)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_options
    @item_options = Item.all.map { |item| [item.name, item.id] }
  end
end

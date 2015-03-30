class HomePageController < ApplicationController
  def index
    @categories = Category.all
  end
end

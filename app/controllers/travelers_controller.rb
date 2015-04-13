class TravelersController < ApplicationController

  def show
    if current_user != User.find(params[:id])
      redirect_to root_path
      flash[:error] = "You are not authorized to view that page"
    else
      @traveler = current_user
    end
  end

end

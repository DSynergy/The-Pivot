class TravelersController < ApplicationController
  def show
    @traveler = User.find(params[:id])
  end
end

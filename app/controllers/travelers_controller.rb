class TravelersController < ApplicationController
  def show
    @traveler = User.find(1)
  end
end

class HostsController < ApplicationController
  def show
    @host = User.find(params[:id])
  end
end

class HostsController < ApplicationController
  def show
    @host = User.find(params[:id])
    if current_user != @host
      render :guest_show
    end
  end

end

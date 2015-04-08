class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to request.referrer
      session[:user_id] = @user.id
      flash[:notice] = "Hello #{@user.display_name ? @user.display_name : @user.username}! Welcome to TravelHome!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email_address, :password, :display_name)
  end
end

class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Successfully logged in as #{@user.username}"
      session[:user_id] = @user.id
      if @user.admin?
        redirect_to admin_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Login failed"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end
end

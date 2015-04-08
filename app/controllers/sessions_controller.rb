class SessionsController < ApplicationController

  def new
    session[:stored_url] = request.referrer
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Successfully logged in as #{set_name(@user)}"
      session[:user_id] = @user.id
      if @user.admin?
        redirect_to admin_path
      elsif session[:stored_url] != nil
        redirect_to session[:stored_url]
      else
        if request.referrer == root_path
          redirect_to root_path
        else
        redirect_to request.referrer
        end
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

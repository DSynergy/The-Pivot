class SessionsController < ApplicationController

  def new
    session[:stored_url] = request.referrer
  end

  def create
    @user = User.find_by(email_address: params[:session][:email_address])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Successfully logged in as #{set_name(@user)}"
      session[:user_id] = @user.id
      determine_redirect
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

  private

  def determine_redirect
    if @user.admin?
      redirect_to admin_path
    elsif session[:stored_url]
      redirect_to session[:stored_url]
    else
      redirect_to root_path
    end
  end
end

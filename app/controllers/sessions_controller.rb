class SessionsController < ApplicationController
  before_action :previous_url, only: [:create]

  def previous_url
    session[:previous_url] ||= request.referrer
  end

  def new
    session[:stored_url] ||= request.referrer
  end

  def create
    @user = User.find_by(email_address: params[:session][:email_address])
    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = "Successfully logged in as #{set_name(@user)}"
      session[:user_id] = @user.id
      determine_redirect
    else
      session[:previous_url] = request.referrer
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
    if session[:stored_url]
      redirect_to cart_path
    elsif session[:previous_url]
      redirect_to session[:previous_url]
    else
      redirect_to root_path
    end
  end
end

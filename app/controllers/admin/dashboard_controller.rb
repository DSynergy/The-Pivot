class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :redirect_to_login_if_not_logged_in
  before_action :is_admin?

  def show
  end

  def index
  end

end

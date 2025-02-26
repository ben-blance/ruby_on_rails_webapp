# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :require_login
  
  def index
    if current_user.system_admin?
      redirect_to admin_dashboard_path
    elsif current_user.store_owner?
      redirect_to store_owner_dashboard_path
    else
      redirect_to stores_path
    end
  end
end

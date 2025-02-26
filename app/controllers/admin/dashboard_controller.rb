# app/controllers/admin/dashboard_controller.rb
class Admin::DashboardController < ApplicationController
  before_action :require_admin
  
  def index
    @total_users = User.count
    @total_stores = Store.count
    @total_ratings = Rating.count
    @stores = Store.all
  end
end

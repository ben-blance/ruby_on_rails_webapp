# app/controllers/store_owner/dashboard_controller.rb
class StoreOwner::DashboardController < ApplicationController
  before_action :require_store_owner
  
  def index
    @store = Store.find_by(owner_id: current_user.id)
    @ratings = @store.ratings.includes(:user) if @store
    @average_rating = @store.average_rating if @store
  end
end

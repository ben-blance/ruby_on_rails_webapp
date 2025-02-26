# app/controllers/stores_controller.rb
class StoresController < ApplicationController
  before_action :require_login
  
  def index
    @stores = Store.all
    
    # Apply filters if present
    @stores = @stores.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @stores = @stores.where("address LIKE ?", "%#{params[:address]}%") if params[:address].present?
    
    # Apply sorting
    sort_column = params[:sort] || "name"
    sort_direction = params[:direction] || "asc"
    @stores = @stores.order("#{sort_column} #{sort_direction}")
  end
  
  def show
    @store = Store.find(params[:id])
    @rating = @store.ratings.find_by(user_id: current_user.id) || Rating.new(store: @store)
  end
end

# app/controllers/admin/stores_controller.rb
class Admin::StoresController < ApplicationController
  before_action :require_admin
  before_action :set_store, only: [:edit, :update, :destroy]
  
  def index
    @stores = Store.all
    
    # Apply filters if present
    @stores = @stores.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @stores = @stores.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
    @stores = @stores.where("address LIKE ?", "%#{params[:address]}%") if params[:address].present?
    
    # Apply sorting
    sort_column = params[:sort] || "name"
    sort_direction = params[:direction] || "asc"
    @stores = @stores.order("#{sort_column} #{sort_direction}")
  end
  
  def new
    @store = Store.new
    @store_owners = User.where(role: :store_owner)
    @owners = User.where(role: :store_owner)
  end
  
  def create
    @store = Store.new(store_params)
    
    if @store.save
      redirect_to admin_stores_path, notice: "Store created successfully"
    else
      @store_owners = User.where(role: :store_owner)
      @owners = User.where(role: :store_owner)
      render :new
    end
  end
  
  def edit
    @store_owners = User.where(role: :store_owner)
  end
  
  def update
    if @store.update(store_params)
      redirect_to admin_stores_path, notice: "Store updated successfully"
    else
      @store_owners = User.where(role: :store_owner)
      render :edit
    end
  end
  
  def destroy
    @store.destroy
    redirect_to admin_stores_path, notice: "Store deleted successfully"
  end
  
  private
  
  def set_store
    @store = Store.find(params[:id])
  end
  
  def store_params
    params.require(:store).permit(:name, :email, :address, :owner_id)
  end
end

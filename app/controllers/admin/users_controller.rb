# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.all
    
    # Apply filters if present
    @users = @users.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
    @users = @users.where("address LIKE ?", "%#{params[:address]}%") if params[:address].present?
    @users = @users.where(role: params[:role]) if params[:role].present?
    
    # Apply sorting
    sort_column = params[:sort] || "name"
    sort_direction = params[:direction] || "asc"
    @users = @users.order("#{sort_column} #{sort_direction}")
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(admin_user_params)
    
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(admin_user_params)
      redirect_to admin_users_path, notice: "User updated successfully"
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully"
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :role)
  end
end

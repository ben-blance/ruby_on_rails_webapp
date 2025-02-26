# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.role = :normal_user
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Account created successfully"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:password].present?
      if @user.update(user_params)
        redirect_to dashboard_path, notice: "Password updated successfully"
      else
        render :edit
      end
    else
      flash.now[:alert] = "Password cannot be blank"
      render :edit
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
  end
  
  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to access this page"
    end
  end
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :is_admin?, :is_store_owner?
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    current_user.present?
  end
  
  def is_admin?
    logged_in? && current_user.system_admin?
  end
  
  def is_store_owner?
    logged_in? && current_user.store_owner?
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "You must be logged in to access this page"
    end
  end
  
  def require_admin
    unless is_admin?
      redirect_to root_path, alert: "You don't have permission to access this page"
    end
  end
  
  def require_store_owner
    unless is_store_owner?
      redirect_to root_path, alert: "You don't have permission to access this page"
    end
  end
end

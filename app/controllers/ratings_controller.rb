# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController
  before_action :require_login
  before_action :set_store
  before_action :set_rating, only: [:update]
  
  def create
    @rating = Rating.new(rating_params)
    @rating.user = current_user
    @rating.store = @store
    
    if @rating.save
      redirect_to store_path(@store), notice: "Rating submitted successfully"
    else
      redirect_to store_path(@store), alert: @rating.errors.full_messages.join(", ")
    end
  end
  
  def update
    if @rating.update(rating_params)
      redirect_to store_path(@store), notice: "Rating updated successfully"
    else
      redirect_to store_path(@store), alert: @rating.errors.full_messages.join(", ")
    end
  end
  
  private
  
  def set_store
    @store = Store.find(params[:store_id])
  end
  
  def set_rating
    @rating = Rating.find_by(user_id: current_user.id, store_id: @store.id)
  end
  
  def rating_params
    params.require(:rating).permit(:value)
  end
end

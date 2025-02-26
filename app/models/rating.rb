# app/models/rating.rb
class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :store
  
  # Validations
  validates :value, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :store_id, message: "has already rated this store" }
end

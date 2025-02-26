# app/models/store.rb
class Store < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  has_many :ratings, dependent: :destroy
  
  # Validations
  validates :name, presence: true, length: { minimum: 20, maximum: 60 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 400 }
  
  # Calculate average rating
  def average_rating
    ratings.average(:value)&.round(1) || 0
  end
end

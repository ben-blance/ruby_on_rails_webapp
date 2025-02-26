# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :stores, dependent: :destroy, foreign_key: :owner_id
  
  # Roles enum
  enum role: { normal_user: 0, store_owner: 1, system_admin: 2 }
  
  # Validations
  validates :name, presence: true, length: { minimum: 5, maximum: 60 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 400 }
  validate :password_complexity
  
  private
  
  def password_complexity
    return if password.blank?
    
    unless password.length.between?(8, 16) && 
           password.match(/[A-Z]/) && 
           password.match(/[!@#$%^&*(),.?":{}|<>]/)
      errors.add(:password, "must be 8-16 characters and include at least one uppercase letter and one special character")
    end
  end
end

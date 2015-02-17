class User < ActiveRecord::Base
  validates :name, length: {maximum: 30}, presence: true, uniqueness: true
  validates :password, length: {maximum: 50, minimum: 6}, presence: true 
  has_secure_password
end

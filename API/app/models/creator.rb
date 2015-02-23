class Creator < ActiveRecord::Base
  has_many :resturants
  validates :fname, presence: true
  validates :lname, presence: true
  has_secure_password
end

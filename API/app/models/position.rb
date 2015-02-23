class Position < ActiveRecord::Base
  has_many :resturants
  
    validates :longitude, presence: true
    validates :latitude, presence: true
end

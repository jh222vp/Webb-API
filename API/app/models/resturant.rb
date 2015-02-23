class Resturant < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :creator
  belongs_to :position
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :position
end

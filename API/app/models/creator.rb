class Creator < ActiveRecord::Base
  has_many :events
  validates :fname, presence: true
  validates :lname, presence: true
end

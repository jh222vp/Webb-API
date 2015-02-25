class Resturant < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_and_belongs_to_many :tags
  belongs_to :creator
  belongs_to :position
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :position
  
  # this is called for both as_json and to_xml
  def serializable_hash (options={})
    options = {
    # declare what we want to show
      only: [:name, :description],
      include: {tags: {only: [:category]}, position: {only: [:latitude, :longitude]}, creator: {only: [:username, :fname, :lname]} },
    }.update(options)
    json = super(options)
    json['url'] = self_link
    self.tags.each.with_index{ |tag, index|
      json['tags'][index]['url'] = tag_link(tag)
      }
    
    json['position']['url'] = position_link
    json
  end
  
  def self_link
   "#{Rails.configuration.baseurl}#{api_api_path(self)}" 
  end

 def tag_link(tag)
   "#{Rails.configuration.baseurl}#{api_tag_path(tag)}" 
  end

 def position_link
   "#{Rails.configuration.baseurl}#{api_position_path(self.tags[0])}" 
  end
end


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
      include: [tags: {only: [:category]}, position: {only: [:latitude, :longitude]}],
    }.update(options)
    json = super(options)
    json['url'] = self_link
    json
  end
  
  def self_link
    # the configuration is set i config/enviroment/{development|productions}.rb
    # include Rails.application.routes.url_helpers - MVC?
   "#{Rails.configuration.baseurl}#{api_api_path(self)}" 
  end


end


class Api::ApiController < ApplicationController
  respond_to :json, :xml
  
  before_action :api_authenticate


  def index
    @user = Resturant.all
      respond_with @user 
      end
    
  def show
    @resturant = Resturant.find_by_id(params[:id])
      respond_with @resturant
    end
  
   def api_authenticate
      if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
        
        #key = User.find_by_key('375600670e508cc1460b8896cb4fd1fd') 
        key = User.find_by_key(auth_header)
      if !key
      render json: { error: 'The provided token wasn´t correct' }, status: :bad_request
      end
      else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
      end
   end
  
  def create
    resturant = Resturant.new(resturant_params)
    #tag = Tag.new(tag_params)
    #position = Position.new(position_params)
    #resturant.tags << tag
    
    respond_to do |format|
      if resturant.save #&& tag.save && position.save
        format.json { render json: resturant, status: :created }
        format.xml { render xml: resturant, status: :created }
      else
        format.json { render json: resturant.errors, status: :unprocessable_entity }
        format.xml { render xml: resturant.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  private
  def resturant_params
    params.require(:resturant).permit(:name, :description, :tags_attributes [:category],:positions_attributes[:longitude,:latitude])
  end
end

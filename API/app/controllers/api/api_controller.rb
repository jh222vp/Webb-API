class Api::ApiController < ApplicationController
  include ErrorsHelper
  protect_from_forgery with: :null_session
  respond_to :json, :xml
  before_action :api_authenticate

  
  
   def index
      @resturant = Resturant.all.order(created_at: :desc)
      if offset_params.present?
        @resturant = Resturant.limit(@limit).offset(@offset).order(created_at: :desc)
      end
      if @resturant.empty?
        @error = ErrorMessage.new("No resturants could be find")
        respond_with @error, status: :ok
      else
        respond_with @resturant
      end
    end


    
  def show
    @resturant = Resturant.find_by_id(params[:id])
    respond_with @resturant
    end
  
   def api_authenticate
      if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
        
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

    respond_to do |format|
      if resturant.save
        format.json { render json: resturant, status: :created }
        format.xml { render xml: resturant, status: :created }
      else
        format.json { render json: resturant.errors, status: :unprocessable_entity }
        format.xml { render xml: resturant.errors, status: :unprocessable_entity }
      end
    end   
  end

#HÄR UPDATERAR VI
def update
  resturant = Resturant.find(params[:id])
  new_resturant = resturant.update(resturant_params)
  render json: resturant, status: :ok
  rescue ActiveRecord::RecordNotFound
  displayError("We could not find the required resturant. Check the ID!")
end

#HÄR TAR VI BORT
def destroy
  @resturant = Resturant.find(params[:id])
  @resturant.destroy
  render json: 'The resturant was deleted', status: :ok
  rescue ActiveRecord::RecordNotFound
  displayError("We could not find the required resturant. Check the ID!")
  render json: error, status: :not_found
end
  
private
  def resturant_params
    params.require(:resturant).permit(:name, :description, tags_attributes:[:category], position_attributes:[:longitude, :latitude])
  end
end
